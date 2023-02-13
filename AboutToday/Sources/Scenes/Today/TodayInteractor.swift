//
//  TodayInteractor.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import Foundation
import CoreLocation
import Photos

protocol TodayBusinessLogic {
    func startUpdatingLocation()
    func requestCurrentLocation()
    func loadWeather()
    func requestPhotoImages(size: CGSize)
}

protocol TodayDataStore {
    var weather: Weather? { get }
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
        guard let latitude, let longitude else { return }
        Task {
            do {
                weather = try await weatherWorker.getWeather(latitude: latitude, longitude: longitude)
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
   
    //MARK: Photos
    func requestPhotoImages(size: CGSize) {
        guard let fetchedPhotosAsset else { return }
        var response = [PhotoImage.Fetched.Response]()
        
        let imageManager = PHImageManager()
        fetchedPhotosAsset.enumerateObjects { asset, index, stop in
            imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: nil) { image, info in
                if let image {
                    response.append(PhotoImage.Fetched.Response(image: image))
                }
            }
        }
        presenter?.presentPhotos(response: response)
    }
   
    //MARK: - Output
    var weather: Weather?
    var currentLocation: CLLocation?
    var fetchedPhotosAsset: PHFetchResult<PHAsset>?
    
    private var latitude: String? {
        if let currentLocation {
            return String(currentLocation.coordinate.latitude)
        } else {
            return nil
        }
    }
    
    private var longitude: String? {
        if let currentLocation {
            return String(currentLocation.coordinate.longitude)
        } else {
            return nil
        }
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
