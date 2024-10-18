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
            CityListView(viewModel: viewModel) { city in
                Button(action: {
                    selectedCity = city
                }, label: {Text(city.name)})
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
        CityListView(viewModel: viewModel) { city in
            NavigationLink {
                CityDetailView(city: city)
            } label: {
                Text(city.name + ", " + city.country)
            }
        }
    }
}

#Preview {
    ContentView()
}
