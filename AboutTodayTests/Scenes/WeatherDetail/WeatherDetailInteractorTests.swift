//
//  WeatherDetailInteractorTests.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/15.
//

import XCTest
@testable import AboutToday

final class WeatherDetailInteractorTests: XCTestCase {

    //MARK: - System under test
    var sut: WeatherDetailInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = WeatherDetailInteractor()
        sut.presenter = weatherDetailPresentLogicSpy
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Test Doubles
    var weatherDetailPresentLogicSpy = WeatherDetailPresentLogicSpy()
    
    final class WeatherDetailPresentLogicSpy: WeatherDetailPresentLogic{
        
        var presentWeatherDetailCalled = false
        
        func presentWeatherDetail(response: AboutToday.WeatherDetail.Loaded.Response) {
            presentWeatherDetailCalled = true
        }
    }
    
    //MARK: - Tests
    func test_loadWeatherDetail_shouldCallPresenterToPresentWeather_whenWeatherIsGiven() {
        ///given
        let weather = Seeds.Dummy.weather
        sut.weather = weather
        ///when
        sut.loadWeatherDetail()
        ///then
        XCTAssert(weatherDetailPresentLogicSpy.presentWeatherDetailCalled)
    }
    
    func test_loadWeatherDetail_shouldNotCallPresenterToPresentWeather_whenWeatherIsNotGiven() {
        ///when
        sut.loadWeatherDetail()
        ///then
        XCTAssertFalse(weatherDetailPresentLogicSpy.presentWeatherDetailCalled)
    }
}
