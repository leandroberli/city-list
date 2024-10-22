//
//  FavoriteCitiesRepository.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 18/10/2024.
//

import Foundation

protocol FavoriteCitiesRepositoryProtocol {
    func isFavorite(city: City) -> Bool
    func setFavorite(city: City, isFavorite: Bool)
}

public struct FavoriteCitiesRepository: FavoriteCitiesRepositoryProtocol {
    let defaults = UserDefaults.standard
    
    public func isFavorite(city: City) -> Bool {
        defaults.bool(forKey: "\(city.id)")
    }
    
    public func setFavorite(city: City, isFavorite: Bool) {
        defaults.set(isFavorite, forKey: "\(city.id)")
    }
}
