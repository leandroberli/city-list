//
//  ContentView.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 16/10/2024.
//

import SwiftUI
import MapKit

struct CityListView: View {
    @StateObject var viewModel = CityListViewModel(citiesService: CitiesService(), favoriteCitiesRepository: FavoriteCitiesRepository())
    @State private var selectedCity: City?
    @State private var showDetails: Bool = false
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        HStack(spacing: 0) {
            NavigationStack {
                ScrollView {
                    Picker("Select a city list", selection: $viewModel.selectedListType) {
                        ForEach(ListType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.leading)
                    .padding(.trailing)
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.filteredCities) { city in
                            CityCellView(city: city, favoriteAction: {
                                viewModel.setFavoriteCity(city)
                            }, didSelectAction: {
                                selectedCity = city
                                showDetails = orientation.isLandscape ? false : true
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
                .navigationTitle("Cities")
                .searchable(text: $viewModel.searchText, isPresented: $viewModel.searchIsActive)
                .onChange(of: viewModel.searchText, { viewModel.setupCityFiltering() })
            }
            .frame(maxWidth: orientation.isLandscape ? UIScreen.main.bounds.size.width/3 : .infinity)
            if orientation.isLandscape {
                Color.secondary.frame(width: 1).opacity(0.5)
                if let selectedCity = selectedCity {
                    CityDetailView(city: selectedCity)
                } else {
                    Spacer()
                }
            }
        }
        .onAppear {
            viewModel.fetchCities() { }
        }
        .onRotate { orientation in
            self.orientation = orientation
            ///Fix bug: avoid repeated map view when you are in map detail protrait mode and then go to landscape mode
            if orientation.isLandscape {
                showDetails = false
            }
        }
    }
}

#Preview {
    CityListView()
}
