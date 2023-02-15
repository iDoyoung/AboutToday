//
//  WeatherDetailViewControllerTests.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/15.
//

import XCTest
@testable import AboutToday

final class WeatherDetailViewControllerTests: XCTestCase {

    //MARK: - System Under Test
    var sut: WeatherDetailViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = WeatherDetailViewController()
        sut.interactor = weatherDetailInteractorSpy
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Test doubles
    var weatherDetailInteractorSpy = WeatherInteractorSpy()
    
    final class WeatherInteractorSpy: WeatherDetailBusinessLogic, WeatherDetailDataStore {
        var loadWeatherDetailCalled = false
        var weather: AboutToday.Weather? = Seeds.Dummy.weather
        
        func loadWeatherDetail() {
            loadWeatherDetailCalled = true
        }
    }
   
    //MARK: - Tests
    func test_viewDidLoad_shouldCallInteractorToLoadWeatherDetail() {
        sut.viewDidLoad()
        XCTAssert(weatherDetailInteractorSpy.loadWeatherDetailCalled)
    }
}
