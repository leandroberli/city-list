//
//  CityDetailView.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 17/10/2024.
//

import SwiftUI
import MapKit

public struct CityDetailView: View {
    @ObservedObject var viewModel: CityDetailViewModel
    @State private var showingSheet = false
    
    public init(city: City) {
        self.viewModel = CityDetailViewModel(city: city)
    }
    
    public var body: some View {
        VStack {
            Map(position: $viewModel.region) {
                Marker(viewModel.city.name, coordinate: CLLocationCoordinate2D(latitude:  Double(viewModel.city.coord.lat), longitude:  Double(viewModel.city.coord.lon)))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            Button(action: { showingSheet.toggle() }, label: {
                Text("See city information")
            })
            .padding()
            .sheet(isPresented: $showingSheet) {
                ZStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Country: " + viewModel.city.country)
                        Text("Name: " + viewModel.city.name)
                        Text("latitude: \(viewModel.city.coord.lon)")
                        Text("longitude: \(viewModel.city.coord.lat)")
                    }
                    .padding()
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                showingSheet = false
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            .padding()
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

