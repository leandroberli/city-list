//
//  CitiesService.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 16/10/2024.
//

import Foundation
import Combine

protocol CitiesServiceProtocol {
    func getCities() -> AnyPublisher<[City], Error>
}

final class CitiesService: CitiesServiceProtocol {
    let apiClient = URLSessionAPIClient<CitiesEndpoint>()
    
    func getCities() -> AnyPublisher<[City], any Error> {
        return apiClient.request(.getCities)
    }
}

