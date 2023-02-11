//
//  TodayPresenterTests.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/05.
//

import XCTest
import Combine
import MapKit
@testable import AboutToday

final class TodayPresenterTests: XCTestCase {

    //MARK: System Under Test
    var sut: TodayPresenter!
    private var cancellableBag = Set<AnyCancellable>()
    
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
        
        var displayLocationErrorCalled = false
        var displayCurrentLocationCalled = false
        @Published var displayWeatherCalled = false
        
        func displayCurrentLocation(region: MKCoordinateRegion) {
            displayCurrentLocationCalled = true
        }
        
        func displayWeather(viewModel: AboutToday.TodayWeather.Fetched.ViewModel) {
            displayWeatherCalled = true
        }
        
        func displayLocationError() {
            displayLocationErrorCalled = true
        }
    }
    
    //MARK: Tests
    func test_presentCurrentLocation_shouldCallViewController() {
        ///given
        let location = CLLocation(latitude: 0.5, longitude: 0.5)
        ///when
        sut.presentCurrentLocation(location)
        ///then
        XCTAssert(todayDidplayLogicSpy.displayCurrentLocationCalled)
    }
    
    func test_presentWeather_whenReceiveResponse() {
        ///given
        let promise = expectation(description: "Display Logic Be Called")
        todayDidplayLogicSpy.$displayWeatherCalled
            .sink { isCalled in
                if isCalled {
                    promise.fulfill()
                }
            }
            .store(in: &cancellableBag)
        let response = Seeds.Dummy.todayWeatherResponse
        ///when
        sut.presentWeather(response: response)
        wait(for: [promise], timeout: 1)
        ///then
        XCTAssert(todayDidplayLogicSpy.displayWeatherCalled)
    }
    
    func test_presentLocationError_shouldCallViewController() {
        sut.presentLocationError()
        XCTAssert(todayDidplayLogicSpy.displayLocationErrorCalled)
    }
}
