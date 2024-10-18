//
//  CityModel.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 16/10/2024.
//

import Foundation

public struct City: Codable {
    let country: String
    let name: String
    let _id: Int
    let coord: Coordinates
}

extension City: Hashable {
    public static func == (lhs: City, rhs: City) -> Bool {
        lhs._id == rhs._id
    }
}

extension City: Identifiable {
    public var id: Int {
        return _id
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
