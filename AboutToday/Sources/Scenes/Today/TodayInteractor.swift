//
//  TodayInteractor.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import UIKit

protocol TodayBusinessLogic {
    func loadWeather(latitude: String, longitude: String) async throws
}

protocol TodayDataStore {
}

final class TodayInteractor: TodayBusinessLogic, TodayDataStore {
    
    private var weatherWorker: WeatherWorker
    var presenter: TodayPresenting?
    
    init(weatherWorker: WeatherWorker) {
        self.weatherWorker = weatherWorker
    }
    
    //MARK: - Input
    func loadWeather(latitude: String, longitude: String) async throws {
        do {
            weather = try await weatherWorker.getWeather(latitude: latitude, longitude: longitude)
        } catch let error {
            errorOfWeather = error
        }
    }
    
    //MARK: - Output
    var weather: Weather? = nil {
        didSet {
        }
    }
    
    var errorOfWeather: Error? = nil {
        didSet {
        }
    }
}
