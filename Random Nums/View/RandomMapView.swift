//
//  RandomMapView.swift
//  Random Nums
//
//  Created by MaxOS on 24.07.2023.
//

import SwiftUI
import MapKit
import CoreLocation

struct RandomMapView: View {
    
    @StateObject private var viewModelMap = RandomMapViewModel()
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @Environment(\.dismiss) var dismiss
    @State var textRadius = ""
    @State private var isShowDirection = false
    @State private var isShowAlert = false
    @FocusState private var keyIsFocused: Bool
    
    func getRegion() -> Binding<MKCoordinateRegion> {
        guard let coordinate = viewModelMap.currentLocation else {
            return .constant(MKCoordinateRegion.defaultRegion)
        }
        return .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    }
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            Map(coordinateRegion: getRegion(), interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: viewModelMap.pins) { pin in
                MapAnnotation(coordinate: pin.coordinatePin) {
                        Image("Marker2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    
                }
            }
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button("Выход в главное меню") {
                        self.dismiss()
                    }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), endColor: .white, textColor: Color.gray))
                        .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                    Button("Вернуться к моей геолокации") {
                        viewModelMap.getMyLocation()
                    }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: .white , endColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), textColor: Color.gray))
                                            .frame(width: UIScreen.main.bounds.width / 2, alignment: .trailing)
                }
                Spacer()
                VStack {
                    HStack {
                        TextField("Радиус в километрах", text: $textRadius)
                            .frame(width: UIScreen.main.bounds.width / 2)
                            .font(.title3)
                            .modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9) , endColor: .white , textColor: Color.gray))
                            .keyboardType(.decimalPad)
                            .focused($keyIsFocused)
                        
                        
                        Button("OK") {
                            if textRadius.isEmpty {
                                isShowAlert.toggle()
                            } else {
                                viewModelMap.randomMap.range = Double(Int(textRadius)!)
                                keyIsFocused.toggle()
                            }
                        }.frame(width: UIScreen.main.bounds.width / 4)
                            .modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: .white , endColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), textColor: Color.gray))
                            .alert("Введите значение радиуса", isPresented: $isShowAlert) {
                                Button("Ok") { }
                            }
                        
                    }
                    Button("Случайная точка в радиусе") {
                        viewModelMap.getMapPin()
                    }.frame(width: UIScreen.main.bounds.width - 50)
                        .font(.title2)
                        .modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: .white , endColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), textColor: Color.gray))
                    Button("Случайная метка на карте") {
                        viewModelMap.getMapRandomLocation()
                    }.frame(width: UIScreen.main.bounds.width - 50)
                     .font(.title2)
                     .modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: .white , endColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), textColor: Color.gray))
                    
                    
                    
                    
                }
            }
            
        }
    }
}
    
struct RandomMapView_Previews: PreviewProvider {
        static var previews: some View {
            RandomMapView()
        }
        
}
