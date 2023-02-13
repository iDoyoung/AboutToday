//
//  TodayInteractorTests.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/02.
//

import XCTest
import Combine
import CoreLocation
import Photos

@testable import AboutToday

final class TodayInteractorTests: XCTestCase {

    //MARK: - System under test
    var sut: TodayInteractor!
    private var cancellableBag = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TodayInteractor(weatherWorker: weatherWorkerSpy, photosWorker: photosWorkerSpy)
        sut.presenter = todayPresenterSpy
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - Test Doubles
    let weatherWorkerSpy = WeatherWorkerSpy(weatherRepository: WeatherRepositoryStub(), weatherIconRepository: WeatherIconRepositoryStub())
    let todayPresenterSpy = TodayPresenterSpy()
    let photosWorkerSpy = PhotosWorkerSpy(photosRepository: PhotosRepositoryStub())
    
    class WeatherWorkerSpy: WeatherWorker {
       
        @Published var weatherWorkerCalled = false
        
        override func getWeather(latitude: String, longitude: String) async throws -> Weather {
            weatherWorkerCalled = true
            return Seeds.Dummy.weather
        }
    }
    
    class PhotosWorkerSpy: PhotosWorker {
        var getTodaysPhotosCalled = false
        
        override func getTodaysPhotos() -> PHFetchResult<PHAsset> {
            getTodaysPhotosCalled = true
            return PHFetchResult<PHAsset>()
        }
    }
    
    class WeatherRepositoryStub: WeatherRepository {
        
        func fetchWeather(latitude: String, longitude: String) async throws -> AboutToday.Weather {
            return Seeds.Dummy.weather
        }
    }
    
    class WeatherIconRepositoryStub: WeatherIconRepository {
        
        func fetchImage(with imagePath: String) async throws -> Data {
            return Data()
        }
    }
    
    class PhotosRepositoryStub: PhotosRepository {
        func fetchPhotosOfToday() -> PHFetchResult<PHAsset> {
            return PHFetchResult<PHAsset>()
        }
    }
    
    class TodayPresenterSpy: TodayPresenting {
        
        var presentCurrentLocationCalled = false
        var presentLocationErrorCalled = false
        @Published var presentWeatherCalled = false
        
        func presentCurrentLocation(_ location: CLLocation) {
          presentCurrentLocationCalled = true
        }
        
        func presentLocationError() {
            presentLocationErrorCalled = true
        }
        
        func presentWeather(response: AboutToday.TodayWeather.Fetched.Response) {
            presentWeatherCalled = true
        }
    }
    
    //MARK: - Tests
    func test_requestCurrentLocation_whenGivenRestrictedOfLocationAuthorization_shouldCallPresenterToPresentError() {
        ///given
        sut.coreLocationAuthorization = .restricted
        ///when
        sut.requestCurrentLocation()
        ///then
        XCTAssert(todayPresenterSpy.presentLocationErrorCalled)
    }
    
    func test_requestCurrentLocation_test_requestCurrentLocation_whenGivenDeniedOfLocationAuthorization_shouldCallPresenterToPresentError_shouldCallPresenterToPresentError() {
        ///given
        sut.coreLocationAuthorization = .denied
        ///when
        sut.requestCurrentLocation()
        ///then
        XCTAssert(todayPresenterSpy.presentLocationErrorCalled)
    }
    
    //TODO: - Test requestCurrentLocation when use CLLocation delegate
    
    func test_loadWeather_whenGiveCurrentLocation_shouldCallWeatherWorker() {
        ///given
        sut.currentLocation = CLLocation(latitude: 0.5, longitude: 0.5)
        let promise = expectation(description: "Worker Be Called")
        weatherWorkerSpy.$weatherWorkerCalled
            .sink { isCalled in
                if isCalled {
                    promise.fulfill()
                }
            }
            .store(in: &cancellableBag)
        ///when
        sut.loadWeather()
        wait(for: [promise], timeout: 1)
        ///then
        XCTAssert(weatherWorkerSpy.weatherWorkerCalled)
    }
    
    func test_loadWeather_whenGiveCurrentLocation_shouldCallPresenter() {
        ///given
        sut.presenter = todayPresenterSpy
        sut.currentLocation = CLLocation(latitude: 0.5, longitude: 0.5)
        
        let promise = expectation(description: "Presenter Be Called")
        todayPresenterSpy.$presentWeatherCalled
            .sink { isCalled in
                if isCalled {
                    promise.fulfill()
                }
            }
            .store(in: &cancellableBag)
        ///when
        sut.loadWeather()
        wait(for: [promise], timeout: 1)
        ///then
        XCTAssert(todayPresenterSpy.presentWeatherCalled)
    }
    
    func test_fetch() {
        ///given
        ///when
        sut.fetchPhotos()
        ///then
        XCTAssert(photosWorkerSpy.getTodaysPhotosCalled)
    }
}
