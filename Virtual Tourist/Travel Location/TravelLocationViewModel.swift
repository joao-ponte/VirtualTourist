//
//  TravelLocationViewModel.swift
//  Virtual Tourist
//
//  Created by João Ponte on 19/07/2023.
//

import Foundation
import MapKit

class TravelLocationViewModel {
    
    let userDefaults: UserDefaultsProtocol
    private let database: DataControllerProtocol
    private let imageRepository: ImageRepositoryProtocol
    var pins: [(latitude: Double, longitude: Double)]? {
        database.pins?.compactMap { (latitude: $0.latitude, longitude: $0.longitude) }
    }
    
    let zoomLevel: MKCoordinateSpan
    let center: CLLocationCoordinate2D
    private let londonLat = 51.5072
    private let LondonLon = 0.1276
    
    init(database: DataControllerProtocol, imageRepository: ImageRepositoryProtocol = FlickrAPI(), userDefaults: UserDefaultsProtocol = UserDataDefaults()) {
        self.database = database
        self.imageRepository = imageRepository
        self.userDefaults = userDefaults
        
        let latitude = userDefaults.readDouble(forKey: "latitude")
        let longitude = userDefaults.readDouble(forKey: "longitude")
        let latDelta = userDefaults.readDouble(forKey: "latitudeDelta")
        let longDelta = userDefaults.readDouble(forKey: "longitudeDelta")

        if userDefaults.readBool(forKey: "locationHasBeenLoaded") {
            zoomLevel = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
            center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        } else {
            zoomLevel = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            center = CLLocationCoordinate2D(latitude: londonLat, longitude: LondonLon)
        }
    }
    // MARK: - User Defaults
    func saveLocationHasBeenLoaded() {
        userDefaults.write(true, forKey: "locationHasBeenLoaded")
    }
    
    private func saveCenterPreferences(latitude: Double, longitude: Double) {
        userDefaults.write(latitude, forKey: "latitude")
        userDefaults.write(longitude, forKey: "longitude")
    }
    
    private func saveSpanPreferences(latitudeDelta: Double, longitudeDelta: Double) {
        userDefaults.write(latitudeDelta, forKey: "latitudeDelta")
        userDefaults.write(longitudeDelta, forKey: "longitudeDelta")
    }
    
    func saveLastPosition(region: MKCoordinateRegion) {

        saveCenterPreferences(latitude: region.center.latitude,
                              longitude: region.center.longitude)
        saveSpanPreferences(latitudeDelta: region.span.latitudeDelta,
                            longitudeDelta: region.span.longitudeDelta)
    }

}





