// DataControllerProtocol.swift
// Virtual Tourist
//
// Created by João Ponte on 31/07/2023.

import Foundation

protocol DataControllerProtocol {

    func getImage(at path: String) -> Data?
    func createPin(latitude: Double, longitude: Double)
    func createImage(for album: Album, blob: Data, url: String, id: Int64)
    func deleteImages(from album: Album)
    func deleteImage(_ image: Image)
    var pins: [Pin]? { get }
    var images: [Image]? { get set }
}
