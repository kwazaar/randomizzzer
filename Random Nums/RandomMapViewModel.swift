//
//  RandomMapViewModel.swift
//  Random Nums
//
//  Created by MaxOS on 28.07.2023.
//

import Foundation
import MapKit


class RandomMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var randomMap = RandomMapModel()
    var locationManager = CLLocationManager()
    @Published var latitu = Double()
    @Published var longitu = Double()
    
    @Published var coordinate = [Items]()
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.755969, longitude: 37.617386), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    func getLocation() {
            let authStatus = locationManager.authorizationStatus
            if authStatus == .denied {
                locationManager.requestWhenInUseAuthorization()
            }
            
            if let location = self.locationManager.location {
                latitu = location.coordinate.latitude + (randomMap.multiplierLatitude * randomMap.randomRangeX * randomMap.range)
                longitu = location.coordinate.longitude + (randomMap.multiplierLongitude * randomMap.randomRangeY * randomMap.range)
            }
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitu, longitude: longitu), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
            print("Did update location \(newLocation)")

    }
    
    
    func checkLocationIsEnable() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
        } else {
            print("Не создался менеджер")
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
    
    private func checkLocationAuth() {
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Ограничен")
        case .denied:
            print("Отключен")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        @unknown default:
            break
        }
    }
    
    
    
    
    static let shared = RandomMapModel()
    
}
