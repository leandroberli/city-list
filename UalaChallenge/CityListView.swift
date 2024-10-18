//
//  CityListView.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 17/10/2024.
//

import SwiftUI

public struct CityListView<Content: View>: View {
    //Chequear viewModel. Es necesario pasar el objeto ?
    @ObservedObject var viewModel: CityListViewModel
    @State private var searchText: String = ""
    @State private var searchIsActive = false
    @ViewBuilder var listItem: (City) -> Content
    
    public init(viewModel: CityListViewModel, @ViewBuilder listItem: @escaping (City) -> Content) {
        self.viewModel = viewModel
        self.listItem = listItem
    }
    
    //Chequear si se debe filtrar desde la view. Ver de agregarlo al viewModel
    var searchResults: [City] {
        if searchText.isEmpty {
            return viewModel.cities
        } else {
            return viewModel.cities.filter { $0.name.contains(searchText) }
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

