//
//  WeatherDetailPresenter.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/14.
//

import UIKit

protocol WeatherDetailPresentLogic {
    func presentWeatherDetail(response: WeatherDetail.Loaded.Response)
}

final class WeatherDetailPresenter: WeatherDetailPresentLogic {
    
    weak var viewController: WeatherDetailDisplayLogic?
    
    func presentWeatherDetail(response: WeatherDetail.Loaded.Response) {
        let city = response.city
        let currentTemperature = "\(Int(response.temp.rounded()))º"
        let minTemperature = "L:\(Int(response.minTemp.rounded()))º"
        let maxTemperature = "H:\(Int(response.maxTemp.rounded()))º"
        let description = response.description
        let feelsLike = "\(Int(response.feelsLike.rounded()))º"
        let humidity = "\(response.humidity)%"
        let pressure = "\(response.pressure) hPa"
        let viewModel = WeatherDetail.Loaded.ViewModel(city: city,
                                                       currentTemperature: currentTemperature,
                                                       minTemperature: minTemperature,
                                                       maxTemperature: maxTemperature,
                                                       description: description,
                                                       feelsLike: feelsLike,
                                                       humidity: humidity,
                                                       pressure: pressure)
        viewController?.displayWeather(viewModel: viewModel)
    }
}
