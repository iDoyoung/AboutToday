//
//  TodayViewControllerTests.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/09.
//

import XCTest
@testable import AboutToday

final class TodayViewControllerTests: XCTestCase {

    //MARK: - System under tests
    var sut: TodayViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TodayViewController()
        sut.interactor = todayBusinessLogicSpy
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
   
    //MARK: - Test Doubles
    let todayBusinessLogicSpy = TodayBusinessLogicSpy()
    
    final class TodayBusinessLogicSpy: TodayBusinessLogic {
        
        var requestCurrentLocationCalled = false
        var loadWeatherCalled = false
        var startUpdatingLocationCalled = false
        
        func requestCurrentLocation() {
            requestCurrentLocationCalled = true
        }
        
        func loadWeather() {
            loadWeatherCalled = true
        }
        
        func startUpdatingLocation() {
            startUpdatingLocationCalled = true
        }
    }
    
    //MARK: - Tests
    func test_viewDidLoad_shouldBeCallInteractorToStartUpdatingLocation() {
        ///given
        ///when
        sut.viewDidLoad()
        ///then
        XCTAssert(todayBusinessLogicSpy.startUpdatingLocationCalled)
    }
    
    func test_viewWillAppear_shouldCallInteractorToLoadWeather() {
        ///given
        
        ///when
        sut.viewWillAppear(false)
        ///then
        XCTAssert(todayBusinessLogicSpy.loadWeatherCalled)
    }
    
    func test_viewDidAppear_shouldCallIneractorToReqeustCurrentLocation() {
        ///given
        ///when
        sut.viewDidAppear(false)
        ///then
        XCTAssert(todayBusinessLogicSpy.requestCurrentLocationCalled)
    }
}
