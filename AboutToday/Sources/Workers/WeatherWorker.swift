//
//  WeatherWorker.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import Foundation

class WeatherWorker {
    
    private let weatherRepository: WeatherRepository
    private let weatherIconRepository: WeatherIconRepository
   
    init(weatherRepository: WeatherRepository, weatherIconRepository: WeatherIconRepository) {
        self.weatherRepository = weatherRepository
        self.weatherIconRepository = weatherIconRepository
    }
    
    func getWeather(latitude: String, longitude: String) async throws -> Weather {
        return try await weatherRepository.fetchWeather(latitude: latitude, longitude: longitude)
    }
    
    func getWeatherIcon(with imagePath: String) async throws -> Data {
        return try await weatherIconRepository.fetchImage(with: imagePath)
    }
}
