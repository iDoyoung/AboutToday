//
//  Weather.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/01.
//

import Foundation

struct Weather: Decodable {
    
    let id: Int
    let city: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let coordinate: Coordinate
    
    enum CodingKeys: String, CodingKey {
        case id
        case city = "name"
        case main
        case weather
        case wind
        case coordinate = "coord"
    }
    
    struct Main: Codable {
        let temp: Double
        let feels: Double
        let minTemp: Double
        let maxTemp: Double
        let pressure: Int
        let humidity: Int
        
        enum CodingKeys: String, CodingKey {
            case temp
            case humidity
            case feels = "feels_like"
            case minTemp = "temp_min"
            case maxTemp = "temp_max"
            case pressure
        }
    }
    
    struct Weather: Codable {
        let description: String
        let icon: String
    }
    
    struct Wind: Codable {
        let speed: Double
    }
    
    struct Coordinate: Codable {
        let longitude: Double
        let latitude: Double
        
        enum CodingKeys: String, CodingKey {
            case longitude = "lon"
            case latitude = "lat"
        }
    }
}
