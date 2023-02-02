//
//  WeatherWorker.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import Foundation

class WeatherWorker {
    
    private let weatherRepository: WeatherRepository
   
    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }
    
    func getWeather(latitude: String, longitude: String) async throws -> Weather {
        return try await weatherRepository.fetchWeather(latitude: latitude, longitude: longitude)
    }
}
