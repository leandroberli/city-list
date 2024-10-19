//
//  CityDetailView.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 17/10/2024.
//

import SwiftUI
import Combine
import MapKit

final class CityDetailViewModel: ObservableObject {
    @Published var city: City
    @Published var region: MapCameraPosition
    
    init(city: City) {
        self.city = city
        self.region = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(city.coord.lat), longitude: Double(city.coord.lon)), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    }
}

public struct CityDetailView: View {
    @ObservedObject var viewModel: CityDetailViewModel
    
    public init(city: City) {
        self.viewModel = CityDetailViewModel(city: city)
    }
    
    public var body: some View {
        Map(position: $viewModel.region) {
            Marker(viewModel.city.name, coordinate: CLLocationCoordinate2D(latitude:  Double(viewModel.city.coord.lat), longitude:  Double(viewModel.city.coord.lon)))
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

