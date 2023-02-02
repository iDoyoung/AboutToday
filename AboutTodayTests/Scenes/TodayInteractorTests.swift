//
//  TodayInteractorTests.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/02.
//

import XCTest
@testable import AboutToday

final class TodayInteractorTests: XCTestCase {

    //MARK: - System under test
    var sut: TodayInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TodayInteractor(weatherWorker: weatherWorkerSpy)
        
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Test Doubles
    let weatherWorkerSpy = WeatherWorkerSpy(weatherRepository: WeatherRepositoryStub())
    
    class WeatherWorkerSpy: WeatherWorker {
       
        var weatherWorkerCalled = false
        
        override func getWeather(latitude: String, longitude: String) async throws -> Weather {
            weatherWorkerCalled = true
            return Seeds.Dummy.weather
        }
    }
    
    class WeatherRepositoryStub: WeatherRepository {
        func fetchWeather(latitude: String, longitude: String) async throws -> AboutToday.Weather {
            return Seeds.Dummy.weather
        }
    }
    
    //MARK: - Tests
    func test_loadWeather_shouldWeatherCallWorker() async throws {
        try await sut.loadWeather(latitude: "", longitude: "")
        XCTAssert(weatherWorkerSpy.weatherWorkerCalled)
    }
}
