// DataControllerProtocol.swift
// Virtual Tourist
//
// Created by João Ponte on 31/07/2023.

import Foundation
import CoreData
import MapKit

protocol DataControllerProtocol {
    func saveContext()
    
    // MARK: - Pin Management
    func fetchPins(completion: @escaping (Result<[Pin], Error>) -> Void)
    func createPin(latitude: Double, longitude: Double) -> Pin
    func getPin(for annotation: MKAnnotation, completion: @escaping (Result<Pin?, Error>) -> Void)
    
    // MARK: - Album Management
    func createAlbum(for pin: Pin) -> Album
    func fetchAlbums() -> Result<[Album], Error>
    
    // MARK: - Image Management
    func createImage(for album: Album, imageUrl: URL)
    func fetchImages() -> Result<[Image], Error>
    func deleteImage(_ image: Image)
    func saveImages(imageUrls: [URL], for pin: Pin)
    
    // MARK: - Data Loading
    func load(completion: (() -> Void)?)
}
