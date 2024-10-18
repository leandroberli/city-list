//
//  Endpoint.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 16/10/2024.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidResponse
    case invalidData
}

enum CitiesEndpoint: APIEndpoint {
    case getCities
    
    var baseURL: URL {
        return URL(string: "https://gist.githubusercontent.com")!
    }
    
    var path: String {
        "/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json"
    }
    
    var method: HTTPMethod { .get }
    
    var headers: [String : String]? { nil }
    
    var parameters: [String : Any]? { nil }
}
