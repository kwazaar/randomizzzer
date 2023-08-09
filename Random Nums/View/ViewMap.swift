////
////  ViewMap.swift
////  Random Nums
////
////  Created by MaxOS on 09.08.2023.
////
//
//import SwiftUI
//import CoreLocation
//import MapKit
//
//struct ViewMap: View {
//    @StateObject var locationManager = LocationManager()
//    @State var isShowDirection = false
//    @State var isShowAlertMap = false
//    @State var pins: [MapPin] = []
//    @State var pin = MapPin(coordinatePin: CLLocationCoordinate2D())
//    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.755969, longitude: 37.617386), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//
//
//    var body: some View {
//        mapView()
////        Map(coordinateRegion: $mapRegion, showsUserLocation: true, annotationItems: pins) { pin in
////            MapAnnotation(coordinate: pin.coordinatePin) {
////                Button {
////                    isShowDirection.toggle()
////
////                } label: {
////                    Image("Marker")
////                        .resizable()
////                        .scaledToFit()
////                        .frame(width: 100 , height: 100)
////                }
////                .alert("Что вы хотите сделать?", isPresented: $isShowDirection) {
////                    Button("Простроить маршрут") {
////                        print("SВ")
////                    }
////                    Button("Выбрать другую локацию") {
////                        print("qwe")
////                    }
////
////                }
////            }
////        }.ignoresSafeArea()
//
//}
//
//    struct mapView: UIViewRepresentable {
//
//        @StateObject var locationManager = LocationManager()
//        @State var map = MKMapView()
//
//
//
//        func makeCoordinator() -> mapView.Coordinator {
//            return mapView.Coordinator()
//        }
//
//        func makeUIView(context: UIViewRepresentableContext<mapView>) -> MKMapView {
//
//
//            //Начальные и конечные координаты точек на карте
////            if let location = locationManager.location {
//            let sourceCoordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 55.753969, longitude: 37.615386)
//            let destinationCoordinate = CLLocationCoordinate2D(latitude: 55.755969, longitude: 37.617386)
////            } else {
////                let sourceCoordinate = CLLocationCoordinate2D(latitude: 13.086, longitude: 80.2707)
////                let destinationCoordinate = CLLocationCoordinate2D(latitude: 13.090, longitude: 80.2700)
////
////            }
//            //Первоначальное определение положения на карте
//            let region = MKCoordinateRegion(center: sourceCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//
//            //Определяем пины на карте
//            //Начальная точка
//            let sourcePin = MKPointAnnotation()
//            sourcePin.coordinate = sourceCoordinate
//            sourcePin.title = "Source"
//            map.addAnnotation(sourcePin)
//            //Конечная точка
//            let destinationPin = MKPointAnnotation()
//            destinationPin.coordinate = destinationCoordinate
//            destinationPin.title = "Destination"
//
//
//            //Создаем запрос на вычисление маршрута
//            let req = MKDirections.Request()
//            req.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate))
//            req.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
//            req.transportType = .walking
//
//            let directions = MKDirections(request: req)
//
//            //Обрабатываем ошибки при вычислении, если они есть
//            directions.calculate { direct, err in
//                if let error = err {
//                    print("Error: \(error.localizedDescription)")
//                    return
//                }
//                let polyline = direct?.routes.first?.polyline
//                map.addOverlay(polyline!)
//                map.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
//            }
//
//
//
//            map.region = region
//            map.delegate = context.coordinator
//            map.showsUserLocation = true
//            return map
//        }
//
//        func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<mapView>) {
//
//        }
//        class Coordinator: NSObject, MKMapViewDelegate {
//
//            func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//                let render = MKPolylineRenderer(overlay: overlay)
//                render.strokeColor = .red
//                render.lineWidth = 4
//                return render
//            }
//        }
//    }
//
//
//    struct ViewMap_Previews: PreviewProvider {
//        static var previews: some View {
//            ViewMap()
//
//        }
//    }
//}
