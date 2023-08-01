//
//  CoreDataPrintViewModel.swift
//  Virtual Tourist
//
//  Created by João Ponte on 01/08/2023.
//


import Foundation
import CoreData

class CoreDataPrintViewModel {
    private let dataControllerManager: DataControllerManager

    init(dataControllerManager: DataControllerManager) {
        self.dataControllerManager = dataControllerManager
    }

    func printCoreDataContents() {
        printPins()
        printAlbums()
        printImages()
    }

    private func printPins() {
        dataControllerManager.fetchPins { result in
            switch result {
            case .success(let pins):
                print("===== Pins =====")
                for pin in pins {
                    print("Latitude: \(pin.latitude), Longitude: \(pin.longitude)")
                }
            case .failure(let error):
                print("Error fetching pins: \(error)")
            }
        }
    }

    private func printAlbums() {
        switch dataControllerManager.fetchAlbums() {
        case .success(let albums):
            print("===== Albums =====")
            for album in albums {
                if let id = album.id {
                    print("ID: \(id)")
                    if let pin = album.pin {
                        print("Pin Latitude: \(pin.latitude), Longitude: \(pin.longitude)")
                    }
                }
            }
        case .failure(let error):
            print("Error fetching albums: \(error)")
        }
    }

    private func printImages() {
        switch dataControllerManager.fetchImages() {
        case .success(let images):
            print("===== Images =====")
            for image in images {
                if let imageUrl = image.imageUrl, let album = image.album, let pin = album.pin {
                    print("Image URL: \(imageUrl)")
                    print("Associated Pin - Latitude: \(pin.latitude), Longitude: \(pin.longitude)")
                }
            }
        case .failure(let error):
            print("Error fetching images: \(error)")
        }
    }
}




