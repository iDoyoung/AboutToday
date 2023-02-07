//
//  TodayInteractorTests.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/02.
//

import XCTest
import Combine
@testable import AboutToday

final class TodayInteractorTests: XCTestCase {

    //MARK: - System under test
    var sut: TodayInteractor!
    private var cancellableBag = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TodayInteractor(weatherWorker: weatherWorkerSpy)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Test Doubles
    let weatherWorkerSpy = WeatherWorkerSpy(weatherRepository: WeatherRepositoryStub(), weatherIconRepository: WeatherIconRepositoryStub())
    let todayPresenterSpy = TodayPresenterSpy()
    
    class WeatherWorkerSpy: WeatherWorker {
       
        @Published var weatherWorkerCalled = false
        
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
    
    class WeatherIconRepositoryStub: WeatherIconRepository {
        
        func fetchImage(with imagePath: String) async throws -> Data {
            return Data()
        }
    }
    
    class TodayPresenterSpy: TodayPresenting {
        
        @Published var presentWeatherCalled = false
        
        func presentWeather(response: AboutToday.TodayWeather.Fetched.Response) {
            presentWeatherCalled = true
        }
    }
    
    //MARK: - Tests
    func test_loadWeather_shouldWeatherCallWorker() {
        let promise = expectation(description: "Worker Be Called")
        weatherWorkerSpy.$weatherWorkerCalled
            .sink { isCalled in
                if isCalled {
                    promise.fulfill()
                }
            }
            .store(in: &cancellableBag)
        ///when
        sut.loadWeather()
        wait(for: [promise], timeout: 1)
        ///then
        XCTAssert(weatherWorkerSpy.weatherWorkerCalled)
    }
    
    func test_loadWeather_should() {
        ///given
        sut.presenter = todayPresenterSpy
        
        let promise = expectation(description: "Presenter Be Called")
        todayPresenterSpy.$presentWeatherCalled
            .sink { isCalled in
                if isCalled {
                    promise.fulfill()
                }
            }
            .store(in: &cancellableBag)
        ///when
        sut.loadWeather()
        wait(for: [promise], timeout: 1)
        ///then
        XCTAssert(todayPresenterSpy.presentWeatherCalled)
    }
}
