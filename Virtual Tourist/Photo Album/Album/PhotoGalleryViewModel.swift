//
//  PhotoGalleryViewModel.swift
//  Virtual Tourist
//
//  Created by João Ponte on 20/07/2023.
//

import Foundation
import MapKit

class PhotoGalleryViewModel {
    
    private let service: ImageRepositoryProtocol
    private let database: DataControllerProtocol
    private var photosFromAPI: [Photo] = []
    
    private var totalPhotos: Int = 0
    private var maxPages: Int?
    private var pageNumber: Int {
        
        guard let maxPages = maxPages,
              maxPages > 0 else { return 1 }
        return Int.random(in: 1...maxPages)
    }
    
    private let album: Album
    private var albumStatus: PhotoAlbumStatus {
        PhotoAlbumStatus(rawValue: album.status ?? "") ?? .notStarted
    }
    var isNewCollectionEnabled: Bool {
        albumStatus == .done && maxPages != 0
    }
    var isNoImageViewHidden: Bool {
        cachedImages.count != 0 || albumStatus != .done
    }
    
    var reloadView: (() -> Void)?
    
    private var cachedImages: [Image] {
        guard let imagesFromPhotoAlbum = album.images,
              imagesFromPhotoAlbum.count > 0,
              let images = imagesFromPhotoAlbum.allObjects as? [Image] else {
            return []
        }
        return images.sorted { $0.id > $1.id }
    }
    
    var latitude: Double
    var longitude: Double
    
    init(photoAlbum: Album,
         service: ImageRepositoryProtocol,
         database: DataControllerProtocol,
         latitude: Double,
         longitude: Double) {
        self.album = photoAlbum
        self.service = service
        self.database = database
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // MARK: - Networking
    
    func getPhotosFromFlickr(_ completion: @escaping () -> Void) {
        
        service.getImages(latitude: latitude, longitude: longitude, pageNumber: pageNumber) { result in
            switch result {
            case .success(let photos):
                self.totalPhotos = photos.total
                self.maxPages = photos.pages
                self.photosFromAPI = photos.photo.sorted { $0.id > $1.id }
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: - Data Source
    func numberOfItems() -> Int {
        albumStatus == .done ? cachedImages.count : photosFromAPI.count
    }
    
    func image(at index: Int) -> UIImage? {
        if albumStatus == .done {
            guard let blob = cachedImages[index].blob else { return nil }
            return UIImage(data: blob)
            
        } else {
            
            let id = Int(photosFromAPI[index].id)!
            guard let cacheImage = cachedImages.first(where: { $0.id == id }),
                  let blob = cacheImage.blob else { return nil }
            return UIImage(data: blob)
        }
    }
    
    // MARK: - Collection View Delegate
    func deleteImage(at index: Int) {
        guard albumStatus == .done else { return }
        let imageToDelete = cachedImages[index]
        database.deleteImage(imageToDelete)
        reloadView?()
    }
    
    // MARK: - Photos
    func fetchPhotos() {
        if albumStatus == .done {
            reloadView?()
            
        } else {
            getPhotosFromFlickr {
                self.reloadView?()
                self.downloadImages { _ in }
            }
        }
    }
    
    private func downloadImages(_ completion: @escaping (Result<Void, Error>) -> Void) {
        changeAlbumStatus(to: .downloading)
        let imagesInAlbum = cachedImages.map { $0.id }
        
        let downloadGroup = DispatchGroup()
        
        photosFromAPI.forEach { photo in
            guard let id = Int64(photo.id), let urlString = photo.imageUrlString else { return }
            
            if imagesInAlbum.contains(id) {
                self.reloadView?()
            } else {
                guard let url = URL(string: urlString) else {
                    completion(.failure(NSError(domain: "🤯", code: 24)))
                    return
                }
                downloadGroup.enter()
                
                service.downloadContent(from: url) { data in
                    if let data = data {
                        self.database.createImage(for: self.album,
                                                  blob: data,
                                                  url: urlString,
                                                  id: id)
                    }
                    downloadGroup.leave()
                }
            }
        }
        downloadGroup.notify(queue: .main) {
            self.changeAlbumStatus(to: .done)
            self.reloadView?()
            completion(.success(()))
        }
    }
    
    // MARK: - Album
    func createNewCollection() {
        database.deleteImages(from: album)
        changeAlbumStatus(to: .notStarted)
        photosFromAPI.removeAll()
        
        reloadView?()
        
        fetchPhotos()
    }
    // MARK: - Helper methods
    private func changeAlbumStatus(to status: PhotoAlbumStatus) {
        
        database.changeStatus(of: album, to: status)
        
        reloadView?()
    }
}
