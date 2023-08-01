//
//  CLLocationCoordinate2D+Extensions.swift
//  Virtual Tourist
//
//  Created by João Ponte on 31/07/2023.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
