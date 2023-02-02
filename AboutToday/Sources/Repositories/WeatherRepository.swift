//
//  WeatherRepository.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import Foundation

protocol WeatherRepository {
    func fetchWeather(latitude: String, longitude: String) async throws -> Weather
}

final class DefaultWeatherRepository: WeatherRepository {
    
    private let service: NetworkDataCodableServiceProtocol
    
    init(service: NetworkDataCodableServiceProtocol) {
        self.service = service
    }
    
    func fetchWeather(latitude: String, longitude: String) async throws -> Weather {
        let endpoint = APIEndpoints.getCurrentLocation(latitude: latitude, longitude: longitude)
        return try await service.request(with: endpoint)
    }
}
