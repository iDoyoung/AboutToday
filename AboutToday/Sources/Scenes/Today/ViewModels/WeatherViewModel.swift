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
            let weather: Weather
        }
        
        struct ViewModel {
            let image: UIImage
        }
    }
}
