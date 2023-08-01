// DataControllerProtocol.swift
// Virtual Tourist
//
// Created by João Ponte on 31/07/2023.

import Foundation
import CoreData

protocol DataControllerProtocol {
    func saveContext()
    
    // MARK: - Pin Management
    func fetchPins(completion: @escaping (Result<[Pin], Error>) -> Void)
    func createPin(latitude: Double, longitude: Double) -> Pin
    
    // MARK: - Album Management
    func createAlbum(for pin: Pin) -> Album
    func deleteImages(for album: Album)
    func fetchAlbums() -> Result<[Album], Error>
    
    // MARK: - Image Management
    func createImage(for album: Album, imageUrl: URL)
    func getImages(for albumID: UUID) -> [Image]?
    func fetchImages() -> Result<[Image], Error>
    func deleteImage(_ image: Image)
    func saveImages(imageUrls: [URL], for pin: Pin)
    
    // MARK: - Data Loading
    func load(completion: (() -> Void)?)
}
