//
//  DetailMapPresenterTests.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/17.
//

import XCTest
import CoreLocation
import MapKit

@testable import AboutToday

final class DetailMapPresenterTests: XCTestCase {

    //MARK: - System Under Test
    var sut: DetailMapPresenter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DetailMapPresenter()
        sut.viewController = detailMapViewControllerSpy
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Test Doubles
    var detailMapViewControllerSpy = DetailMapDisplayLogicSpy()
    
    final class DetailMapDisplayLogicSpy: DetailMapDisplayLogic {
        
        var displayAnnotationOfLocationCalled = false
        var displayCurrentLocationCalled = false
        
        func displayAnnotationOfLocation(viewModel: AboutToday.PhotosLocation.Loaded.ViewModel) {
            displayAnnotationOfLocationCalled = true
        }
        
        func displayCurrentLocation(region: MKCoordinateRegion) {
            displayCurrentLocationCalled = true
        }
    }
    
    //MARK: - tests
    func test_presentPhotosLocation_shouldCallViewControllerWhenReceiveResponse() {
        ///given
        let response = Seeds.Dummy.responseOfPhotosLocation///
        ///when
        sut.presentPhotosLocations(response: response)
        ///then
        XCTAssert(detailMapViewControllerSpy.displayAnnotationOfLocationCalled)
    }
    
    func test_presentCurrentLocation_shouldCallViewController() {
        sut.presentCurrentLocation(CLLocation())
        XCTAssert(detailMapViewControllerSpy.displayCurrentLocationCalled)
    }
}
