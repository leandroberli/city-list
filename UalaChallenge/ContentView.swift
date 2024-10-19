//
//  ContentView.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 16/10/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var viewModel = CityListViewModel(citiesService: CitiesService())
    @State private var selectedCity: City?
    @State private var showDetails: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView {
                    Picker("Select a city", selection: $viewModel.selectedListType) {
                        ForEach(ListType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.leading)
                    .padding(.trailing)
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.getCities()) { city in
                            CityCellView(city: city, favoriteAction: {
                                viewModel.setFavoriteCity(city)
                            }, didSelectAction: {
                                selectedCity = city
                                showDetails = true
                            })
                        }
                    }
                    .padding()
                    .navigationDestination(isPresented: $showDetails) {
                        if let selectedCity = selectedCity {
                            CityDetailView(city: selectedCity)
                        }
                    }
                }
            }
            .navigationTitle("Cities")
        }
        .searchable(text: $viewModel.searchText, isPresented: $viewModel.searchIsActive)
        .onAppear {
            viewModel.fetchCities()
        }
    }
}

#Preview {
    ContentView()
}
