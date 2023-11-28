//
//  RandomMapViewModel.swift
//  Random Nums
//
//  Created by MaxOS on 28.07.2023.
//

import Foundation
import MapKit
import Combine
import CoreLocation

@MainActor
class RandomMapViewModel: ObservableObject {
    
    private let locationManager: LocationManager
    var cancelleble: AnyCancellable?
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var pins: [MapPin] = []
    @Published var pin = MapPin()
    @Published var coordinateItem: Items.Coordinate?
    
    
    @Published var randomMap = RandomMapModel()
    @Published var latitu = Double()
    @Published var longitu = Double()

    init(){
        locationManager = LocationManager()
        
        cancelleble = locationManager.$location.sink { (location) in
            if let location = location {
                DispatchQueue.main.async {
                    self.currentLocation = location.coordinate
                }
            }
        }
    }
    func getMyLocation() {
        if let location = locationManager.location {
                self.currentLocation = location.coordinate
        }
    }
    func getMapPin() {
        if let location = locationManager.location {
            latitu = location.coordinate.latitude + (randomMap.multiplierLatitude * randomMap.randomRangeX * randomMap.range)
            longitu = location.coordinate.longitude + (randomMap.multiplierLongitude * randomMap.randomRangeY * randomMap.range)
            self.currentLocation?.latitude = latitu
            self.currentLocation?.longitude = longitu
            pin.coordinatePin = CLLocationCoordinate2D(latitude: latitu, longitude: longitu)
            pins.append(pin)
            if pins.count >= 2 {
                pins.removeFirst()
            }
        }
    }
    func getMapRandomLocation() {
        NetworkingServiceWithCompletion.shared.fetchData { result in
            switch result {
            case .success(let coordinateData):
                let coordinate = coordinateData.items[0]
                self.coordinateItem = coordinate
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                
            }
        }
        if let latitude = self.coordinateItem?.lat, let longitude = self.coordinateItem?.lon {
            self.currentLocation?.latitude = latitude
            self.currentLocation?.longitude = longitude
            self.pin.coordinatePin = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self.pins.append(self.pin)
            if self.pins.count >= 2 {
                self.pins.removeFirst()
            }
        }
    }
    
    static let shared = RandomMapModel()
    
}
