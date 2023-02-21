//
//  TodayInteractor.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import Foundation
import CoreLocation
import Photos

enum FethcError: Error {
    case noData
}

protocol TodayBusinessLogic {
    func startUpdatingLocation()
    func requestCurrentLocation()
    func loadWeather()
    func requestPhotoImages(size: CGSize)
}

protocol TodayDataStore {
    var weather: Weather? { get }
    var currentLocation: CLLocation? { get }
    var fetchedPhotosAsset: PHFetchResult<PHAsset>? { get }
}

final class TodayInteractor: NSObject, TodayBusinessLogic, TodayDataStore {
    
    private var weatherWorker: WeatherWorker
    private var coreLocationManager = CLLocationManager()
    var coreLocationAuthorization: CLAuthorizationStatus
    
    var presenter: TodayPresenting?
    
    init(weatherWorker: WeatherWorker, photosWorker: PhotosWorker) {
        self.weatherWorker = weatherWorker
        self.coreLocationAuthorization = coreLocationManager.authorizationStatus
        fetchedPhotosAsset = photosWorker.getTodaysPhotos()
    }
    
    //MARK: Location
    func startUpdatingLocation() {
        coreLocationManager.delegate = self
        coreLocationManager.requestWhenInUseAuthorization()
    }
    
    func requestCurrentLocation() {
        handleLocationAuthorization()
    }

    private func handleLocationAuthorization() {
        switch coreLocationAuthorization {
        case .restricted, .denied:
            presenter?.presentLocationError()
        case .notDetermined, .authorizedAlways, .authorizedWhenInUse://TODO: - Consider when authorization is not determinded.
            coreLocationManager.requestLocation()
        @unknown default:
            #if DEBUG
            print("Unknown")
            #endif
            presenter?.presentLocationError()
        }
    }
    
    //MARK: Network
    func loadWeather() {
        if let currentLocation {
            let request = getTodayWeatherRequest(with: currentLocation)
            Task {
                do {
                    weather = try await weatherWorker.getWeather(latitude: request.latitude, longitude: request.longitude)
                    guard let weather else { return }
                    guard let imagePath = weather.weather.first?.icon else { return }
                    let imageData = try await weatherWorker.getWeatherIcon(with: imagePath)
                    let reponse = TodayWeather.Fetched.Response(city: weather.city,
                                                                temp: weather.main.temp,
                                                                minTemp: weather.main.minTemp,
                                                                maxTemp: weather.main.maxTemp,
                                                                imageData: imageData)
                    presenter?.presentWeather(response: reponse)
                } catch let error {
                    print(error)
                }
            }
        }
    }
   
    //MARK: Photos
    func requestPhotoImages(size: CGSize) {
        Task {
            await presenter?.presentPhotos(response: reqeustImages(size: size))
        }
    }
   
    private func reqeustImages(size: CGSize) async -> [PhotoImage.Fetched.Response] {
        var response = [PhotoImage.Fetched.Response]()
        if let fetchedPhotosAsset {
            for index in 0..<fetchedPhotosAsset.count {
                let image = await withCheckedContinuation { continuation in
                    reqeustImageSynchronous(with: fetchedPhotosAsset[index], size: size) { image in
                        continuation.resume(returning: image)
                    }
                }
                response.append(image)
            }
        }
        return response
    }
    
    private func reqeustImageSynchronous(with asset: PHAsset, size: CGSize, completion: @escaping (PhotoImage.Fetched.Response) -> Void) {
        DispatchQueue.global().async {
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            let imageManger = PHImageManager.default()
            imageManger.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options) { image, _ in
                guard let image else { return }
                completion(PhotoImage.Fetched.Response(image: image))
            }
        }
    }
    
    //MARK: - Output
    var weather: Weather?
    var currentLocation: CLLocation?
    var fetchedPhotosAsset: PHFetchResult<PHAsset>?
    
    private func getTodayWeatherRequest(with location: CLLocation) -> TodayWeather.Fetched.Repuest {
        let latitiude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        return TodayWeather.Fetched.Repuest(latitude: latitiude, longitude: longitude)
    }
}

extension TodayInteractor: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location
            coreLocationManager.stopUpdatingLocation()
            presenter?.presentCurrentLocation(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //TODO: Reponse To rquest location and call Presenter
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        coreLocationAuthorization = manager.authorizationStatus
        handleLocationAuthorization()
    }
}
