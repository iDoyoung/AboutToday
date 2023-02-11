//
//  TodayInteractor.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import Foundation
import CoreLocation

protocol TodayBusinessLogic {
    func startUpdatingLocation()
    func requestCurrentLocation()
    func loadWeather()
}

protocol TodayDataStore {
    var weather: Weather? { get }
}

final class TodayInteractor: NSObject, TodayBusinessLogic, TodayDataStore {
    
    private var weatherWorker: WeatherWorker
    private var coreLocationManager = CLLocationManager()
    var coreLocationAuthorization: CLAuthorizationStatus
    
    var presenter: TodayPresenting?
    
    init(weatherWorker: WeatherWorker) {
        self.weatherWorker = weatherWorker
        self.coreLocationAuthorization = coreLocationManager.authorizationStatus
    }
    
    //MARK: Rqeust Location
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
    
    //MARK: - Output
    var weather: Weather?
    var currentLocation: CLLocation?
    
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
