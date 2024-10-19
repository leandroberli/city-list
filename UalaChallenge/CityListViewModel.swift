//
//  CityListViewModel.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 16/10/2024.
//

import Foundation
import Combine

public enum ListType: String, CaseIterable {
    case all = "Explore"
    case favs = "Likes"
}

public final class CityListViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let citiesService: CitiesServiceProtocol
    private var favoriteCitiesRepository: FavoriteCitiesRepository = FavoriteCitiesRepository()
    private var apiAlreadyFetched: Bool = false
    @Published var cities: [City] = []
    
    @Published var searchText: String = ""
    @Published var searchIsActive = false
    
    @Published var selectedListType: ListType = .all
    
    init(citiesService: CitiesServiceProtocol) {
        self.citiesService = citiesService
    }
    
    func fetchCities() {
        guard !apiAlreadyFetched else { return }
        self.apiAlreadyFetched = true
        
        citiesService.getCities()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { data in
                
            }, receiveValue: {[weak self] data in
                var cities: [City] = []
                for item in data {
                    cities.append(City(country: item.country, name: item.name, _id: item._id, coord: item.coord, favorite: self?.favoriteCitiesRepository.isFavorite(city: item)))
                }
                self?.cities = self?.sortCities(cities) ?? data
                
            }).store(in: &cancellables)
    }
    
    func setFavoriteCity(_ city: City) {
        if let index = cities.firstIndex(where: { $0._id == city._id }) {
            cities[index].favorite = !favoriteCitiesRepository.isFavorite(city: city)
            favoriteCitiesRepository.setFavorite(city: city, isFavorite: !favoriteCitiesRepository.isFavorite(city: city))
        }
    }
    
    func getCities() -> [City] {
        if searchText.isEmpty {
            if selectedListType == .all {
                return cities
            } else {
                return cities.filter({ $0.favorite ?? false })
            }
        } else {
            let cities = cities.filter {
                let lowercased = $0.name.lowercased()
                return lowercased.contains(searchText.lowercased())
            }
            if selectedListType == .all {
                return cities
            } else {
                return cities.filter({ $0.favorite ?? false })
            }
        }
    }
    
    private func sortCities(_ cities: [City]) -> [City] {
        let date1 = Date()
        print(#function)
        let sorted = cities.sorted(by: { $0.name < $1.name })
        print(Date().timeIntervalSince1970 - date1.timeIntervalSince1970)
        return sorted
    }
}
