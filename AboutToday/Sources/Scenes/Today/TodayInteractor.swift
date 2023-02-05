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
                let response = TodayWeather.Fetched.Response(weather: weather?.weather ?? [])
                guard let imagePath = response.weather.first?.icon else { return }
                try await loadWeatherIconImage(with: imagePath)
            } catch let error {
                print(error)
            }
        }
    }
    
    private func loadWeatherIconImage(with imagePath: String) async throws {
        let responseOfIcon = try await weatherWorker.getWeatherIcon(with: imagePath)
        presenter?.presentWeatherIcon(response: responseOfIcon)
    }
    
    //MARK: - Output
    var weather: Weather?
}
