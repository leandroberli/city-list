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
    
    func fetchCities() -> AnyPublisher<[City], any Error> {
        let cities = [City(country: "ES", name: "Barcelona", id: 1, coord: Coordinates(lon: 0, lat: 0)),
                      City(country: "ES", name: "Madrid", id: 2, coord: Coordinates(lon: 0, lat: 0)),
                      City(country: "AR", name: "Buenos Aires", id: 3, coord: Coordinates(lon: 0, lat: 0)),
                      City(country: "BR", name: "Rio de Janeiro", id: 4, coord: Coordinates(lon: 0, lat: 0), favorite: false)]
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
    
    func testGetAllCitiesAndSortArray() throws {
        let expectation = self.expectation(description: "Fetching cities")
        
        viewModel.fetchCities {
            expectation.fulfill()
        }
        
        viewModel.searchText = ""
        
        waitForExpectations(timeout: 5) { error in
            if error != nil {
                XCTFail("Failed to fetch cities in time")
            }
        }
        
        let expectedResult = [CityCellModel(city: City(country: "ES", name: "Barcelona", id: 1, coord: Coordinates(lon: 0, lat: 0))), CityCellModel(city: City(country: "AR", name: "Buenos Aires", id: 3, coord: Coordinates(lon: 0, lat: 0))), CityCellModel(city: City(country: "ES", name: "Madrid", id: 2, coord: Coordinates(lon: 0, lat: 0))), CityCellModel(city:  City(country: "BR", name: "Rio de Janeiro", id: 4, coord: Coordinates(lon: 0, lat: 0), favorite: false))]
        
        XCTAssertEqual(self.viewModel.cities, expectedResult)
    }
    
    func testGetAllCitiesAndWrongSortArrayResult() throws {
        let expectation = self.expectation(description: "Fetching cities")
        
        viewModel.fetchCities {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if error != nil {
                XCTFail("Failed to fetch cities in time")
            }
        }
        
        let cities = self.viewModel.getCities()
        
        let wrongResult = [CityCellModel(city: City(country: "ES", name: "Barcelona", id: 1, coord: Coordinates(lon: 0, lat: 0))), CityCellModel(city: City(country: "AR", name: "Buenos Aires", id: 3, coord: Coordinates(lon: 0, lat: 0))), CityCellModel(city: City(country: "ES", name: "Madrid", id: 2, coord: Coordinates(lon: 0, lat: 0)))]
        
        XCTAssertNotEqual(cities, wrongResult)
    }

    func testSearchCitiesWithValidSearchStringAndResults() throws {
        let expectation = self.expectation(description: "Fetching cities")
        let searchExpectation = self.expectation(description: "Searching cities")
        
        viewModel.fetchCities {
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
        viewModel.searchText = "B"
 
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            searchExpectation.fulfill()
        }
        
        self.wait(for: [searchExpectation], timeout: 5)
        
        let result = [CityCellModel(city: City(country: "ES", name: "Barcelona", id: 1, coord: Coordinates(lon: 0, lat: 0))), CityCellModel(city:  City(country: "AR", name: "Buenos Aires", id: 3, coord: Coordinates(lon: 0, lat: 0)))]
        XCTAssertEqual(self.viewModel.cities, result)
    }
    
    func testSearchCitiesWithValidSearchStringAndOneResult() throws {
        let expectation = self.expectation(description: "Fetching cities")
        let searchExpectation = self.expectation(description: "Searching cities")
        
        viewModel.fetchCities {
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
        viewModel.searchText = "buenos"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            searchExpectation.fulfill()
        }
        
        self.wait(for: [searchExpectation], timeout: 5)
        
        let result: [CityCellModel] = [CityCellModel(city: City(country: "AR", name: "Buenos Aires", id: 3, coord: Coordinates(lon: 0, lat: 0)))]

        XCTAssertEqual(viewModel.cities, result)
    }
    
    func testSearchCitiesWithInvalidSearchString() throws {
        let expectation = self.expectation(description: "Fetching cities")
        
        viewModel.fetchCities {
            expectation.fulfill()
        }
        viewModel.searchText = "$%"
        
        waitForExpectations(timeout: 5) { error in
            if error != nil {
                XCTFail("Failed to fetch cities in time")
            }
        }
        
        let cities = self.viewModel.getCities()
        let result: [CityCellModel] = []
        
        XCTAssertEqual(cities, result)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
