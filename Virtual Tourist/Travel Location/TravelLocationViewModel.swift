//
//  TravelLocationViewModel.swift
//  Virtual Tourist
//
//  Created by João Ponte on 19/07/2023.
//

import Foundation
import MapKit

class TravelLocationViewModel {
    var pins: [Pin] = []
    let dataControllerManager: DataControllerManager
    
    init(dataControllerManager: DataControllerManager) {
        self.dataControllerManager = dataControllerManager
        loadPins()
    }
    
    func addPin(at coordinate: CLLocationCoordinate2D) {
        dataControllerManager.savePin(latitude: coordinate.latitude, longitude: coordinate.longitude)
        loadPins()
    }
    
    private func loadPins() {
        pins = dataControllerManager.fetchPins()
    }
    
    func savePins() {
        dataControllerManager.savePins(pins)
    }
}


