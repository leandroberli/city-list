//
//  CityModel.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 16/10/2024.
//

import Foundation

public struct City: Codable, Identifiable {
    let country: String
    let name: String
    public let id: Int
    let coord: Coordinates
    var favorite: Bool? = false
    
    enum CodingKeys: String, CodingKey {
            case country
            case name
            case id = "_id" // Mapea la propiedad _id a "id" en el JSON
            case coord  // Mapea coord a "coordinates" en el JSON
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
