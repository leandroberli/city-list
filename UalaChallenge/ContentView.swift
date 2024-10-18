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
    
    var body: some View {
        CustomSplitView(landscapeView: {
            CityListView(cities: viewModel.cities) { city in
                Button(action: {
                    selectedCity = city
                }, label: {
                    CityCellView(city: city, favoriteAction: { viewModel.setFavoriteCity(city) })
                })
            }
            if let selectedCity = selectedCity {
                CityDetailView(city: selectedCity)
            } else {
                EmptyView()
            }
        }, portrait: {
            portraitView
        })
        .onAppear {
            viewModel.fetchCities()
        }
    }
    
    var portraitView: some View {
        CityListView(cities: viewModel.cities) { city in
            NavigationLink {
                CityDetailView(city: city)
            } label: {
                CityCellView(city: city, favoriteAction: { viewModel.setFavoriteCity(city) })
            }
        }
    }
}

#Preview {
    ContentView()
}
