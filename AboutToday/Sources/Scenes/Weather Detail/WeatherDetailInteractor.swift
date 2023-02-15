//
//  WeatherDetailInteractor.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/14.
//

import Foundation

protocol WeatherDetailBusinessLogic {
    func loadWeatherDetail()
}

protocol WeatherDetailDataStore {
    var weather: Weather? { get set }
}

final class WeatherDetailInteractor: WeatherDetailBusinessLogic, WeatherDetailDataStore {
    
    var presenter: WeatherDetailPresentLogic?
    var weather: Weather?
    
    func loadWeatherDetail() {
        guard let weather else { return }
        let description = weather.weather.isEmpty ? "" : weather.weather[0].description
        let response = WeatherDetail.Loaded.Response(city: weather.city,
                                                     temp: weather.main.temp,
                                                     minTemp: weather.main.minTemp,
                                                     maxTemp: weather.main.maxTemp,
                                                     description: description,
                                                     feelsLike: weather.main.feels,
                                                     humidity: weather.main.humidity,
                                                     pressure: weather.main.pressure)
        presenter?.presentWeatherDetail(response: response)
    }
}
