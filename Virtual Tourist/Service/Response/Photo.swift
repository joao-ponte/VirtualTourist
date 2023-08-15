//
//  FlickrPhoto.swift
//  Virtual Tourist
//
//  Created by João Ponte on 26/07/2023.
//

import Foundation

struct Photo: Codable {
    let id: String
    let secret: String
    let server: String
    
    var imageUrl: URL? {
        let urlString = "https://live.staticflickr.com/\(server)/\(id)_\(secret)_m.jpg"
        return URL(string: urlString)
    }
}
