//
//  TodayInteractor.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import Foundation
import CoreLocation

protocol TodayBusinessLogic {
    func loadWeather()
    func startUpdatingLocation()
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
   
    func loadWeather() {
        Task {
            do {
                weather = try await weatherWorker.getWeather(latitude: "37.244500226941", longitude: "127.05758053117")
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
}

extension TodayInteractor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            //TODO: Reponse To rquest location and call Presenter
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        //TODO: Reponse To rquest location and call Presenter
    }
}
