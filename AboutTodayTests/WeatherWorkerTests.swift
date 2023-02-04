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
        sut = WeatherWorker(weatherRepository: weatherRepositorySpy, weatherIconRepository: weatherIconRepositorySpy)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    //MARK: - Test doubles
    let weatherRepositorySpy = WeatherRepositorySpy()
    let weatherIconRepositorySpy = WeatherIconRepositorySpy()
    
    class WeatherRepositorySpy: WeatherRepository {
        var calledFetchWeather = false
        
        func fetchWeather(latitude: String, longitude: String) async throws -> AboutToday.Weather {
            calledFetchWeather = true
            return Seeds.Dummy.weather
        }
    }
    
    class WeatherIconRepositorySpy: WeatherIconRepository {
        var calledFetchWeather = false
        
        func fetchImage(with imagePath: String) async throws -> Data {
            calledFetchWeather = true
            return Data()
        }
    }
    
    //MARK: - Tests
    func test_getWeather_shouldBeCallRepository() async throws {
        _ = try await sut.getWeather(latitude: "", longitude: "")
        XCTAssert(weatherRepositorySpy.calledFetchWeather)
    }
    
    func test_getWeather() async throws {
        _ = try await sut.getWeatherIcon(with: "")
        XCTAssert(weatherIconRepositorySpy.calledFetchWeather)
    }
}
