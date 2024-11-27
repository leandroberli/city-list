//
//  CityModel.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 16/10/2024.
//

import Foundation

public struct CityCellModel {
    var city: City
    var isFavorite: Bool {
        get {
            UserDefaults.standard.bool(forKey: "\(city.id)")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "\(city.id)")
        }
    }
    var lowercasedName: String
    
    public init(city: City) {
        self.city = city
        self.lowercasedName = city.name.lowercased()
    }
}

extension CityCellModel: Identifiable {
    public var id: Int { city.id }
}

extension CityCellModel: Hashable {
    public static func == (lhs: CityCellModel, rhs: CityCellModel) -> Bool {
        lhs.city.id == rhs.city.id
    }
}

public struct City: Codable, Identifiable {
    let country: String
    let name: String
    public let id: Int
    let coord: Coordinates
    var favorite: Bool? = false
    
    enum CodingKeys: String, CodingKey {
            case country
            case name
            case id = "_id" 
            case coord
            case favorite
        }
}

extension City: Hashable {
    public static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id
    }
}

struct Coordinates: Codable {
    let lon: Float
    let lat: Float
}

extension Coordinates: Hashable {
    static func == (lhs: Coordinates, rhs: Coordinates) -> Bool {
        lhs.lon == rhs.lon && lhs.lat == rhs.lat
    }
}
