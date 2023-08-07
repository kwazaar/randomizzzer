//
//  MapPin.swift
//  Random Nums
//
//  Created by MaxOS on 06.08.2023.
//

import Foundation
import MapKit


struct MapPin : Identifiable {
    let id = UUID()
    var coordinatePin: CLLocationCoordinate2D
}
