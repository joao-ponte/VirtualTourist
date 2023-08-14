//
//  ImageRepositoryProtocol.swift
//  Virtual Tourist
//
//  Created by João Ponte on 26/07/2023.
//

import Foundation

protocol ImageRepositoryProtocol {
    func getImages(latitude: Double,
                   longitude: Double,
                   pageNumber: Int,
                   completion: @escaping ([URL]?, Error?) -> Void)
    func downloadContent(from url: URL) -> Data?

}

