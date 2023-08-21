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
                    "&per_page=24" +
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
                   completion: @escaping (Result<Photos, NetworkError>) -> Void) {
        let endpoint = FlickrAPI.EndPoints.getGeoPhotos(latitude: latitude, longitude: longitude, pageNumber: pageNumber)
        let url = endpoint.url
        client.taskForGetRequest(url: url, response: PhotoAlbum.self) { (photoAlbum, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.badURL))
                } else if let photoAlbum = photoAlbum {
                    completion(.success(photoAlbum.photos))
                } else {
                    completion(.failure(.serviceError))
                }
            }
        }
    }
    
    func downloadContent(from url: URL, completion: @escaping (Data?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            if let data = data {
                completion(data)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
