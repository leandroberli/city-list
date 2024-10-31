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
    private var apiAlreadyFetched: Bool = false
    @Published var cities: [CityCellModel] = []
    @Published var searchText: String = ""
    @Published var searchIsActive = false
    @Published var selectedListType: ListType = .all
    
    init(citiesService: CitiesServiceProtocol) {
        self.citiesService = citiesService
    }
    
    func fetchCities(completion: @escaping (() -> Void)) {
        guard !apiAlreadyFetched else { return }
        self.apiAlreadyFetched = true
        
        citiesService.fetchCities()
            .receive(on: DispatchQueue.global(qos: .userInitiated))
            .map { data in
                let cities = data.map { item in
                    CityCellModel(city: item)
                }
                return self.sortCities(cities)
            }
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
                self.cities = data
                completion()
            }).store(in: &cancellables)
    }
    
    func setFavoriteCity(_ city: City) {
        guard let index = cities.firstIndex(where: { $0.city.id == city.id }) else {
            return
        }
        cities[index].isFavorite = !cities[index].isFavorite
    }
    
    //TODO: Try to improve this operations using concurrency GCD
    func getCities() -> [CityCellModel] {
        print(#function)
        let date = Date()
        var filteredCities = cities
        
        if !searchText.isEmpty {
            let lowercasedSearchText = searchText.lowercased()
            filteredCities = filteredCities.filter { $0.lowercasedName.hasPrefix(lowercasedSearchText) }
        }
        
        if selectedListType != .all {
            filteredCities = filteredCities.filter { $0.isFavorite }
        }
        print("t: ", Date().timeIntervalSince1970 - date.timeIntervalSince1970 )
        return filteredCities
    }
    
    private func sortCities(_ cities: [CityCellModel]) -> [CityCellModel] {
        return cities.sorted(by: { $0.lowercasedName < $1.lowercasedName })
    }
}
