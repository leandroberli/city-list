//
//  FavoriteCitiesRepository.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 18/10/2024.
//

import Foundation

public struct FavoriteCitiesRepository {
    let defaults = UserDefaults.standard
    
    public func isFavorite(city: City) -> Bool {
        defaults.bool(forKey: "\(city._id)")
    }
    
    public func setFavorite(city: City, isFavorite: Bool) {
        defaults.set(isFavorite, forKey: "\(city._id)")
    }
}
