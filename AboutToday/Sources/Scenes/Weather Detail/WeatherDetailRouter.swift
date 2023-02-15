//
//  WeatherDetailRouter.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/15.
//

import UIKit

protocol WeatherDetailRouting { }
protocol WeatherDetailDataPassing {
    var dataStore: WeatherDetailDataStore? { get }
}

final class WeatherDetailRouter: WeatherDetailRouting, WeatherDetailDataPassing {
        
    weak var viewController: WeatherDetailViewController?
    var dataStore: WeatherDetailDataStore?
}
