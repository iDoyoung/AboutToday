//
//  TodayPresenterTests.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/05.
//

import XCTest
@testable import AboutToday

final class TodayPresenterTests: XCTestCase {

    //MARK: System Under Test
    var sut: TodayPresenter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TodayPresenter()
        sut.viewController = todayDidplayLogicSpy
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: Test doubles
    var todayDidplayLogicSpy = TodayDidplayLogicSpy()
    class TodayDidplayLogicSpy: TodayDisplayLogic {
       
        var displayWeatherCalled = false
        
        func displayWeather(viewModel: AboutToday.TodayWeather.Fetched.ViewModel) {
            displayWeatherCalled = true
        }
    }
    
    //MARK: Tests
    func test_presentWeatherIcon_whenReceiveValid() {
        ///given
        let response = Seeds.Dummy.todayWeatherResponse
        ///when
        sut.presentWeather(response: response)
        ///then
        XCTAssert(todayDidplayLogicSpy.displayWeatherCalled)
    }
}
