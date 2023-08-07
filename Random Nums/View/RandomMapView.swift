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
    
    @StateObject var viewModelMap = RandomMapViewModel()
    @State var coordinate : Items.Coordinate?
    @State private var pins: [MapPin] = []
    @State var pin = MapPin(coordinatePin: CLLocationCoordinate2D())
    
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.755969, longitude: 37.617386), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @Environment(\.dismiss) var dismiss
    @State var textRadius = ""
    @State private var isShowDirection = false
    @State private var isShowAlert = false
    @FocusState private var keyIsFocused: Bool
    
    
    
    
    init() {
            viewModelMap.checkLocationIsEnable()
    }
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            Map(coordinateRegion: $mapRegion, showsUserLocation: true, annotationItems: pins) { pin in
                MapAnnotation(coordinate: pin.coordinatePin) {
                                Button {
                                    isShowDirection.toggle()
                                    
                                } label: {
                                    Image("1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(15)
                                }
                                .alert("Что вы хотите сделать?", isPresented: $isShowDirection) {
                                    Button("Простроить маршрут") {
                                        print("SВ")
                                    }
                                    Button("Выбрать другую локацию") {
                                        print("qwe")
                                    }
                                
                                }
                            }
                    }.ignoresSafeArea(.all)
            
            VStack {
                HStack {
                    Button("Выход в главное меню") {
                        self.dismiss()
                    }.modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), endColor: .white, textColor: Color.gray))
                        .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
                    Button("Вернуться к моей геолокации") {
                        self.mapRegion.center = viewModelMap.locationManager.location!.coordinate
                        
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
                            
                            
                        Button("Установить") {
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
                        viewModelMap.getLocation()
                        mapRegion = viewModelMap.region
                        pin.coordinatePin.latitude = viewModelMap.latitu
                        pin.coordinatePin.longitude = viewModelMap.longitu
                        pins.removeAll()
                        pins.append(pin)
                    }.frame(width: UIScreen.main.bounds.width - 50)
                    .font(.title)
                     .modifier(customTextFieldViewModifer(roundedCornes: 15, startColor: .white , endColor: Color(hue: 1.0, saturation: 0.0, brightness: 0.9), textColor: Color.gray))
                    
                    Button("Случайная метка на карте") {
                        NetworkingServiceWithCompletion.shared.fetchData { result  in
                            switch result {
                            case .success(let coordinateData):
                                let coordinate = coordinateData.items[0]
                                self.coordinate = coordinate
                                if let latitude = self.coordinate?.lat, let longitude = self.coordinate?.lon {
                                    self.mapRegion.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                    pin.coordinatePin = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                    pins.removeAll()
                                    pins.append(pin)
                                }
                            case .failure(let failure):
                                print(failure.localizedDescription)
                            }
                        }
                    }.frame(width: UIScreen.main.bounds.width - 50)
                     .font(.title)
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
