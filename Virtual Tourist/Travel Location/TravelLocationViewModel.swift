//
//  TravelLocationViewModel.swift
//  Virtual Tourist
//
//  Created by João Ponte on 19/07/2023.
//

import Foundation
import MapKit

class TravelLocationViewModel {
    
    var pins: [MKPointAnnotation] = []
    
    func addPin(at coordinate: CLLocationCoordinate2D) {
        let newPin = MKPointAnnotation()
        newPin.coordinate = coordinate
        pins.append(newPin)
        
        print(pins)
    }
    
}
