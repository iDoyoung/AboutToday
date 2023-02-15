//
//  WeatherDetailPresenterTests.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/15.
//

import XCTest

@testable import AboutToday

final class WeatherDetailPresenterTests: XCTestCase {
    
    //MARK: - System Under Test
    var sut: WeatherDetailPresenter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = WeatherDetailPresenter()
        sut.viewController = weatherDetailDisplayLogicSpy
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Test Doubles
    var weatherDetailDisplayLogicSpy = WeatherDetailDisplayLogicSpy()
    
    class WeatherDetailDisplayLogicSpy: WeatherDetailDisplayLogic {
        var displayWeatherCalled = false
        
        func displayWeather(viewModel: AboutToday.WeatherDetail.Loaded.ViewModel) {
            displayWeatherCalled = true
        }
    }
    
    //MARK: - Tests
    func test_presentWeather_shouldCallDisplayLogicToDisplayWeather() {
        ///given
        let response = Seeds.Dummy.responseOfWeatherDetail
        ///when
        sut.presentWeatherDetail(response: response)
        ///then
        XCTAssert(weatherDetailDisplayLogicSpy.displayWeatherCalled)
    }
}
