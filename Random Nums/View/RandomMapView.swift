//
//  RandomMapView.swift
//  Random Nums
//
//  Created by MaxOS on 24.07.2023.
//

import SwiftUI
import MapKit

struct RandomMapView: View {
    
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.755969, longitude: 37.617386), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @Environment(\.dismiss) var dismiss
    @State var textCoordinate = ""
    
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
                    Button("Определить местоположение") {
                        print("My location")
                    }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: .white , endColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), textColor: Color.gray))
                        .frame(width: UIScreen.main.bounds.width / 2, alignment: .trailing)
                }
                Text(textCoordinate)
                Spacer()
                Button("Случайная метка на карте") {
                    let jsonUrlString = "https://api.rand.by/v1/geo"
                    guard let url = URL(string: jsonUrlString) else { return }
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data else { return }
                        
                        do {
                            let coordinate = try JSONDecoder().decode(Items.self, from: data)
                            print(coordinate.items[0].lat)
                        } catch let error {
                           print(error)
                        }
                    }.resume()
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
