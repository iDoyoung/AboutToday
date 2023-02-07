//
//  WeatherViewModel.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/03.
//

import UIKit

enum TodayWeather {
    
    enum Fetched {
        
        struct Response {
            let city: String
            let temp: Double
            let minTemp: Double
            let maxTemp: Double
            let imageData: Data
        }
        
        struct ViewModel {
            let city: String
            let currentTemperature: String
            let minTemperature: String
            let maxTemperature: String
            let image: UIImage
        }
    }
}
