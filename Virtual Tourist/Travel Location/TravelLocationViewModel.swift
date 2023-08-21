//
//  TravelLocationViewModel.swift
//  Virtual Tourist
//
//  Created by João Ponte on 19/07/2023.
//

import MapKit
import CoreLocation

class TravelLocationViewModel {
    
    let userDefaults: UserDefaultsProtocol
    private let database: DataControllerProtocol
    var pins: [(latitude: Double, longitude: Double)]? {
        database.pins?.compactMap { (latitude: $0.latitude, longitude: $0.longitude) }
    }
    
    let zoomLevel: MKCoordinateSpan
    let center: CLLocationCoordinate2D
    private let londonLat = 51.5072
    private let londonLong = 0.1276
    
    init(userDefaults: UserDefaultsProtocol = UserDataDefaults(),
         database: DataControllerProtocol = DataControllerManager()) {
        self.userDefaults = userDefaults
        self.database = database
        
        let latitude = userDefaults.readDouble(forKey: "latitude")
        let longitude = userDefaults.readDouble(forKey: "longitude")
        let latDelta = userDefaults.readDouble(forKey: "latitudeDelta")
        let longDelta = userDefaults.readDouble(forKey: "longitudeDelta")
        
        if userDefaults.readBool(forKey: "locationHasBeenLoaded") {
            zoomLevel = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
            center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
        } else {
            zoomLevel = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            center = CLLocationCoordinate2D(latitude: londonLat, longitude: londonLong)
            saveCenterPreferences(latitude: center.latitude, longitude: center.longitude)
            saveSpanPreferences(latitudeDelta: zoomLevel.latitudeDelta, longitudeDelta: zoomLevel.longitudeDelta)
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
    
    // MARK: - Map View
    func plotNewPin(coordinate: CLLocationCoordinate2D, mapView: MKMapView) {
        let annotation = createAnnotation(coordinate: coordinate)
        mapView.addAnnotation(annotation)
    }
    
    func createAnnotation(coordinate: CLLocationCoordinate2D) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        database.createPin(latitude: coordinate.latitude,
                           longitude: coordinate.longitude)
        return annotation
    }
    
    // MARK: - Database
    
    private func findPin(at coordinate: CLLocationCoordinate2D) -> Pin? {
        database.pins?.first(where: { pin in
            pin.latitude == coordinate.latitude && pin.longitude == coordinate.longitude
        })
    }
    
    // MARK: - Navigation
    func makePhotoGalleryViewModel(coordinate: CLLocationCoordinate2D) -> PhotoGalleryViewModel {
        guard let pin = findPin(at: coordinate),
              let album = pin.album else { fatalError("Sorry, can't find pin") }
        return PhotoGalleryViewModel(photoAlbum: album,
                                     service: FlickrAPI(),
                                     database: database,
                                     latitude: coordinate.latitude,
                                     longitude: coordinate.longitude)
    }
}
