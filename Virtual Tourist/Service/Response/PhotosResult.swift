//
//  PhotosResult.swift
//  Virtual Tourist
//
//  Created by João Ponte on 26/07/2023.
//

import Foundation

struct PhotosResult: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [FlickrPhoto]
}
