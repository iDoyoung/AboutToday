//
//  DetailViewControllerTests.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/16.
//

import XCTest
import Photos
@testable import AboutToday

final class DetailViewControllerTests: XCTestCase {

    //MARK: - System under test
    var sut: DetailMapViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DetailMapViewController()
        sut.interactor = detailMapInteractorSpy
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Test Doubles
    let detailMapInteractorSpy = DetailMapInteractorSpy()
    
    final class DetailMapInteractorSpy: DetailMapBusinessLogic, DetailMapDataStore {
        
        var currentLocation: CLLocation?
        
        var loadPhotoLocationsCalled = false
        var loadCurrentLocationCalled = false
        var assets: PHFetchResult<PHAsset>? = nil
        
        func loadPhotoLocations() {
            loadPhotoLocationsCalled = true
        }
        
        func loadCurrentLocation() {
            loadCurrentLocationCalled = true
        }
        
    }
    
    //MARK: - Tests
    func test_viewDidLoad_shouldCallInteractorToLoadPhotoLocations() {
        sut.viewDidLoad()
        XCTAssert(detailMapInteractorSpy.loadPhotoLocationsCalled)
    }
    
    func test_viewDidLoad_shouldCallInteractorToLoadCurrentLocation() {
        sut.viewDidLoad()
        XCTAssert(detailMapInteractorSpy.loadCurrentLocationCalled)
    }
}
