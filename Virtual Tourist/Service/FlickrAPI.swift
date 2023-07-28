//
//  FlickrAPI.swift
//  Virtual Tourist
//
//  Created by João Ponte on 25/07/2023.
//

import Foundation

class FlickrAPI: ImageRepositoryProtocol {
    
    let client: HttpClientProtocol
    
    init(client: HttpClientProtocol = HttpClient()) {
        self.client = client
    }
    
    enum EndPoints {
        static let base = "https://api.flickr.com/services/rest/"
        static let apiKey = "6236676ee91c0152a0d2cbe6ea33a0b6"
        
        case getGeoPhotos(latitude: Double, longitude: Double, pageNumber: Int)
        
        var stringValue: String {
            switch self {
            case .getGeoPhotos(let latitude, let longitude, let pageNumber):
                return EndPoints.base +
                    "?method=flickr.photos.search" +
                    "&api_key=\(EndPoints.apiKey)" +
                    "&lat=\(latitude)" +
                    "&lon=\(longitude)" +
                    "&page=\(pageNumber)" +
                    "&per_page=18" +
                    "&format=json&nojsoncallback=1"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    func getImages(latitude: Double,
                   longitude: Double,
                   pageNumber: Int,
                   completion: @escaping ([URL]?, Error?) -> Void) {
        let endpoint = FlickrAPI.EndPoints.getGeoPhotos(latitude: latitude, longitude: longitude, pageNumber: pageNumber)
        let url = endpoint.url
        client.taskForGetRequest(url: url, response: PhotosResponse.self) { [weak self] (response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                } else {
                    let imageUrls = self?.extractImageUrls(from: response) ?? []
                    completion(imageUrls, nil)
                }
            }
        }
    }

        private func extractImageUrls(from photosResponse: PhotosResponse?) -> [URL] {
            guard let photosResponse = photosResponse else {
                return []
            }
            
            let imageUrls = photosResponse.photos.photo.compactMap { photo in
                return photo.imageUrl
            }
            
            return imageUrls
        }
    
}

