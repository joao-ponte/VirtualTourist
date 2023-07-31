//
//  DataControllerProtocol.swift
//  Virtual Tourist
//
//  Created by João Ponte on 31/07/2023.
//

import Foundation

protocol DataControllerProtocol {
    func saveContext() throws
    func fetchPins() throws -> [Pin]
    func createPin(latitude: Double, longitude: Double) throws
    func createAlbum(for pin: Pin) throws -> Album
    func deleteImages(for album: Album) throws
    func createImage(for album: Album, blob: Data, imageUrl: String, id: Int64) throws
    func getImages(for albumID: UUID) throws -> [Image]?
    func deleteImage(_ image: Image) throws
    func savePins(_ pins: [Pin]) throws
    func load(completion: (() -> Void)?) throws
    func saveImages(imageUrls: [URL], for pin: Pin) throws
}
