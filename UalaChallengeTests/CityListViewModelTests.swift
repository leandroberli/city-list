//
//  CityListViewModelTests.swift
//  UalaChallenge
//
//  Created by Leandro Berli on 20/10/2024.
//

import XCTest
@testable import UalaChallenge
import Combine

final class MockCitiesService: CitiesServiceProtocol {
    var expectation: XCTestExpectation?
    
    func getCities() -> AnyPublisher<[City], any Error> {
        let cities = [City(country: "ES", name: "Barcelona", _id: 1, coord: Coordinates(lon: 0, lat: 0)),
                      City(country: "ES", name: "Madrid", _id: 2, coord: Coordinates(lon: 0, lat: 0)),
                      City(country: "AR", name: "Buenos Aires", _id: 3, coord: Coordinates(lon: 0, lat: 0)),
                      City(country: "BR", name: "Rio de Janeiro", _id: 4, coord: Coordinates(lon: 0, lat: 0), favorite: false)]
        return Just(cities)
                .setFailureType(to: Error.self) // Specify the failure type for compatibility
                .eraseToAnyPublisher()
        
    }
}

final class CityListViewModelTests: XCTestCase {
    
    var viewModel: CityListViewModel!
    var mockCitiesService: MockCitiesService!
    
    override func setUpWithError() throws {
        mockCitiesService = MockCitiesService()
        viewModel = CityListViewModel(citiesService: mockCitiesService)
    }

    override func tearDownWithError() throws {
        mockCitiesService = nil
        viewModel = nil
    }
    
    func testGetCitiesAndSortArrayCorrectly() throws {
        viewModel.fetchCities()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let cities = self.viewModel.getCities()
            
            let expectedResult = [City(country: "ES", name: "Barcelona", _id: 1, coord: Coordinates(lon: 0, lat: 0)),
                                  City(country: "AR", name: "Buenos Aires", _id: 3, coord: Coordinates(lon: 0, lat: 0)),
                                  City(country: "ES", name: "Madrid", _id: 2, coord: Coordinates(lon: 0, lat: 0)),
                                  City(country: "BR", name: "Rio de Janeiro", _id: 4, coord: Coordinates(lon: 0, lat: 0), favorite: false)]
            
            XCTAssertEqual(cities, expectedResult)
        }
    }
    
    func testGetCitiesAndSortArrayResultWrong() throws {
        viewModel.fetchCities()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let cities = self.viewModel.getCities()
            let wrongResult = [City(country: "ES", name: "Barcelona", _id: 1, coord: Coordinates(lon: 0, lat: 0)),
                               City(country: "AR", name: "Buenos Aires", _id: 3, coord: Coordinates(lon: 0, lat: 0)),
                               City(country: "BR", name: "Rio de Janeiro", _id: 4, coord: Coordinates(lon: 0, lat: 0), favorite: false),
                               City(country: "ES", name: "Madrid", _id: 2, coord: Coordinates(lon: 0, lat: 0))]
            
            XCTAssertNotEqual(cities, wrongResult)
        }
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}