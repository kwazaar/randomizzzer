//
//  RandomMapViewModel.swift
//  Random Nums
//
//  Created by MaxOS on 28.07.2023.
//

import Foundation
import MapKit


class RandomMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
//    @Published var randomMap: RandomMapModel
    var locationManager: CLLocationManager?
    @Published var coordinate = [Items]()
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.755969, longitude: 37.617386), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    func checkLocationIsEnable() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            print("Не создался менеджер")
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
    
    private func checkLocationAuth() {
        guard let locationManager = locationManager else { return }
        
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
