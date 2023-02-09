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
    var window: UIWindow!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        window = UIWindow()
        sut = TodayViewController()
        sut.interactor = todayBusinessLogicSpy
    }

    override func tearDownWithError() throws {
        sut = nil
        window = nil
        try super.tearDownWithError()
    }
    
    func loadView() {
        window.addSubview(sut.view)
    }
    
    //MARK: - Test Doubles
    let todayBusinessLogicSpy = TodayBusinessLogicSpy()
    
    final class TodayBusinessLogicSpy: TodayBusinessLogic {
        
        var loadWeatherCalled = false
        var startUpdatingLocationCalled = false
        
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
        loadView()
        ///when
        sut.viewDidLoad()
        ///then
        XCTAssert(todayBusinessLogicSpy.startUpdatingLocationCalled)
    }
}
