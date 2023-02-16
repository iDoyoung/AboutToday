//
//  DetailMapInteractor.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/16.
//

import XCTest
import Photos
@testable import AboutToday

final class DetailMapInteractorTests: XCTestCase {
    
    //MARK: - System under test
    var sut: DetailMapInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DetailMapInteractor()
        sut.presenter = detailMapPresenterSpy
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Test Doubles
    var detailMapPresenterSpy = DetailMapPresenterSpy()
    
    final class DetailMapPresenterSpy: DetailMapPresenting {
        
        var presentPhotosLocationCalled = false
        
        func presentPhotosLocations(response: AboutToday.PhotosLocation.Loaded.Response) {
            presentPhotosLocationCalled = true
        }
    }
    
    //MARK: - Tests
    func test_loadPhotosLocations_shouldCallPresenter() {
        sut.assets = PHFetchResult<PHAsset>()
        sut.loadPhotoLocations()
        XCTAssert(detailMapPresenterSpy.presentPhotosLocationCalled)
    }
}
