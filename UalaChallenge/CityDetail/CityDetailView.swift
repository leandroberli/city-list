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
    @Published var region: MKCoordinateRegion
    
    init(city: City) {
        self.city = city
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(city.coord.lat), longitude: Double(city.coord.lon)), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
}

public struct CityDetailView: View {
    @ObservedObject var viewModel: CityDetailViewModel
    
    public init(city: City) {
        self.viewModel = CityDetailViewModel(city: city)
    }
    
    public var body: some View {
        Map(coordinateRegion: $viewModel.region)
            .frame(width: .infinity, height: .infinity)
    }
}

