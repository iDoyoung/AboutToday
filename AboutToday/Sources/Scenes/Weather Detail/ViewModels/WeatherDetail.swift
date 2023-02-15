//
//  WeatherDetail.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/15.
//

import Foundation

enum WeatherDetail {
    
    enum Loaded {
        
        struct Response {
            let weather: Weather
        }
        
        struct ViewModel {
            let city: String
            let currentTemperature: String
            let minTemperature: String
            let maxTemperature: String
            let description: String
            let feelsLike: String
            let humidity: String
            let pressuer: String
        }
    }
}

