//
//  RandomMapView.swift
//  Random Nums
//
//  Created by MaxOS on 24.07.2023.
//

import SwiftUI
import MapKit

struct RandomMapView: View {
    
    @StateObject var viewModelMap = RandomMapViewModel()
    @State var coordinate : Items.Coordinate?
    
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.755969, longitude: 37.617386), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @Environment(\.dismiss) var dismiss
    @State var textCoordinate = ""
    
    
    
    init() {
        viewModelMap.checkLocationIsEnable()
    }
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            Map(coordinateRegion: $mapRegion, showsUserLocation: true)
                .ignoresSafeArea(.all)
            VStack {
                HStack {
                    Button("Выход в главное меню") {
                        self.dismiss()
                    }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), endColor: .white, textColor: Color.gray))
                        .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                    Button("Вернуться к моей геолокации") {
                        self.mapRegion = viewModelMap.region
                    }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: .white , endColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), textColor: Color.gray))
                        .frame(width: UIScreen.main.bounds.width / 2, alignment: .trailing)
                }
                Text("\(coordinate?.lat ?? 55.755969), \(coordinate?.lon ?? 37.617386)")
                Spacer()
                Button("Случайная метка на карте") {
                        NetworkingServiceWithCompletion.shared.fetchData { result  in
                            switch result {
                            case .success(let coordinateData):
                                let coordinate = coordinateData.items[0]
                                self.coordinate = coordinate
                                if let latitude = self.coordinate?.lat, let longitude = self.coordinate?.lon {
                                    self.mapRegion.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                }
                            case .failure(let failure):
                                print(failure.localizedDescription)
                            }
                        }

                }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), endColor: .white, textColor: Color.gray))
            }
            
        }
    }
}

struct RandomMapView_Previews: PreviewProvider {
    static var previews: some View {
        RandomMapView()
    }
}
