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
    
    var presenter: TodayPresenting?
    
    init(weatherWorker: WeatherWorker) {
        self.weatherWorker = weatherWorker
    }
    
    //MARK: Rqeust Location
    func startUpdatingLocation() {
        coreLocationManager.delegate = self
        coreLocationManager.requestWhenInUseAuthorization()
    }
    
    func requestCurrentLocation() {
        coreLocationManager.requestLocation()
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
        switch manager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            requestCurrentLocation()
        @unknown default:
            #if DEBUG
            print("Unknown")
            #endif
        }
    }
}
