//
//  TodayInteractor.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import UIKit

protocol TodayBusinessLogic {
    func loadWeather()
}

protocol TodayDataStore {
    var weather: Weather? { get }
}

final class TodayInteractor: TodayBusinessLogic, TodayDataStore {
    
    private var weatherWorker: WeatherWorker
    var presenter: TodayPresenting?
    
    init(weatherWorker: WeatherWorker) {
        self.weatherWorker = weatherWorker
    }
    
    func loadWeather() {
        Task {
            do {
                weather = try await weatherWorker.getWeather(latitude: "40.78", longitude: "73.97")
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
