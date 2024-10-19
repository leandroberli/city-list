//
//  CityListView.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 17/10/2024.
//

import SwiftUI

public struct CityListView<Content: View>: View {
        private var cities: [City]
    @State private var searchText: String = ""
    @State private var searchIsActive = false
    @ViewBuilder var listItem: (City) -> Content
    
    public init(cities: [City], @ViewBuilder listItem: @escaping (City) -> Content) {
        self.cities = cities
        self.listItem = listItem
    }
    
    //Chequear si se debe filtrar desde la view. Ver de agregarlo al viewModel
    var searchResults: [City] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter {
                let lowercased = $0.name.lowercased()
                return lowercased.contains(searchText.lowercased())
            }
        }
    }
    
    public var body: some View {
        NavigationStack {
            List(searchResults) { city in
                listItem(city)
            }
        }
        .searchable(text: $searchText, isPresented: $searchIsActive)
    }
}

