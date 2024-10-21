//
//  CityDetailViewModel.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 21/10/2024.
//
import MapKit
import SwiftUI

final class CityDetailViewModel: ObservableObject {
    @Published var city: City
    @Published var region: MapCameraPosition
    
    init(city: City) {
        self.city = city
        self.region = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(city.coord.lat), longitude: Double(city.coord.lon)), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    }
}
