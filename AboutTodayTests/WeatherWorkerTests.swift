//
//  WeatherWorkerTests.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/02.
//

import XCTest
@testable import AboutToday

final class WeatherWorkerTests: XCTestCase {

    //MARK: - System under test
    var sut: WeatherWorker!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = WeatherWorker(weatherRepository: repositorySpy)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    //MARK: - Test doubles
    let repositorySpy = WeatherRepositorySpy()
    
    class WeatherRepositorySpy: WeatherRepository {
        var calledFetchWeather = false
        
        func fetchWeather(latitude: String, longitude: String) async throws -> AboutToday.Weather {
            calledFetchWeather = true
            return Seeds.Dummy.weather
        }
    }
    
    //MARK: - Tests
    func test_() async throws {
        _ = try await sut.getWeather(latitude: "", longitude: "")
        XCTAssert(repositorySpy.calledFetchWeather)
    }
}
