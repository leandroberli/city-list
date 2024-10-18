//
//  CityListViewModel.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 16/10/2024.
//

import Foundation
import Combine

public final class CityListViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let citiesService: CitiesServiceProtocol
    private var apiAlreadyFetched: Bool = false
    @Published var cities: [City] = []
    
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
                self?.cities = self?.sortCities(data) ?? data
            }).store(in: &cancellables)
    }
    
    private func sortCities(_ cities: [City]) -> [City] {
        let date1 = Date()
        print(#function)
        let sorted = cities.sorted(by: { $0.name < $1.name })
        print(Date().timeIntervalSince1970 - date1.timeIntervalSince1970)
        return sorted
    }
}
