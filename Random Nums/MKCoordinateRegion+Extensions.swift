//
//  MKCoordinateRegion+Extensions.swift
//  Random Nums
//
//  Created by MaxOS on 09.08.2023.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    
    static var defaultRegion: MKCoordinateRegion {
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.755969, longitude: 37.617386), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
}
