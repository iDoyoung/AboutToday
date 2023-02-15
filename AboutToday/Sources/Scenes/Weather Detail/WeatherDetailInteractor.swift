//
//  WeatherDetailInteractor.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/14.
//

import Foundation

protocol WeatherDetailBusinessLogic {
}

protocol WeatherDetailDataStore {
    var weather: Weather? { get set }
}

final class WeatherDetailInteractor: WeatherDetailBusinessLogic, WeatherDetailDataStore {
    
    var presenter: WeatherDetailPresentLogic?
    var weather: Weather?
}
