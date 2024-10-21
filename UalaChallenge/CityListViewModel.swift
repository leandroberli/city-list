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
    private var favoriteCitiesRepository: FavoriteCitiesRepositoryProtocol
    private var apiAlreadyFetched: Bool = false
    @Published var cities: [City] = []
    @Published var searchText: String = ""
    @Published var searchIsActive = false
    @Published var selectedListType: ListType = .all
    
    init(citiesService: CitiesServiceProtocol,
         favoriteCitiesRepository: FavoriteCitiesRepositoryProtocol = FavoriteCitiesRepository()) {
        self.citiesService = citiesService
        self.favoriteCitiesRepository = favoriteCitiesRepository
    }
    
    func fetchCities(completion: @escaping (() -> Void)) {
        guard !apiAlreadyFetched else { return }
        self.apiAlreadyFetched = true
        
        citiesService.fetchCities()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print("Error feching cities: \(error.localizedDescription)")
                    self.apiAlreadyFetched = false
                }
            }, receiveValue: {[weak self] data in
                guard let self = self else { return }
                let cities = data.map { item in
                    City(country: item.country, name: item.name, _id: item._id, coord: item.coord, favorite: self.favoriteCitiesRepository.isFavorite(city: item))
                }
                self.cities = self.sortCities(cities)
                completion()
            }).store(in: &cancellables)
    }
    
    func setFavoriteCity(_ city: City) {
        if let index = cities.firstIndex(where: { $0._id == city._id }) {
            cities[index].favorite = !favoriteCitiesRepository.isFavorite(city: city)
            favoriteCitiesRepository.setFavorite(city: city, isFavorite: !favoriteCitiesRepository.isFavorite(city: city))
        }
    }
    
    //TODO: Try to improve this operations using concurrency GCD
    func getCities() -> [City] {
        var filteredCities = cities
        
        if !searchText.isEmpty {
            let lowercasedSearchText = searchText.lowercased()
            filteredCities = filteredCities.filter { $0.name.lowercased().contains(lowercasedSearchText) }
        }
        
        if selectedListType != .all {
            filteredCities = filteredCities.filter { $0.favorite ?? false }
        }
        
        return filteredCities
    }
    
    private func sortCities(_ cities: [City]) -> [City] {
        let date1 = Date()
        print(#function)
        let sorted = cities.sorted(by: { $0.name < $1.name })
        print(Date().timeIntervalSince1970 - date1.timeIntervalSince1970)
        return sorted
    }
}
