//
//  WeatherIconRepository.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/04.
//

import Foundation

protocol WeatherIconRepository {
    func fetchImage(with imagePath: String) async throws -> Data
}

final class DefaultWeatherIconRepository: WeatherIconRepository {
    
    private let service: NetworkServiceProtocol
    
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    func fetchImage(with imagePath: String) async throws -> Data {
        let endpoint = APIEndpoints.getWeatherIcon(with: imagePath)
        return try await service.request(endpoint: endpoint)
    }
}
