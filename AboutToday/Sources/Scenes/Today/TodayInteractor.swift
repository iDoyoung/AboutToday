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
                print(weather)
                //presenter?.presentWeather(response: weather)
            } catch let error {
                print(error)
            }
        }
    }
    
    //MARK: - Output
    var weather: Weather?
}
