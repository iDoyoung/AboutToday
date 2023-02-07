//
//  TodayPresenter.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import UIKit

protocol TodayPresenting {
    func presentWeather(response: TodayWeather.Fetched.Response)
}

final class TodayPresenter: TodayPresenting {
    
    weak var viewController: TodayDisplayLogic?
    
    func presentWeather(response: TodayWeather.Fetched.Response) {
        DispatchQueue.main.async {
            let city = response.city
            let currentTemperature = "\(response.temp)"
            let minTemperature = "\(response.minTemp)"
            let maxTemperature = "\(response.maxTemp)"
            let image = UIImage(data: response.imageData)
            let viewModel = TodayWeather.Fetched.ViewModel(city: city,
                                                           currentTemperature: currentTemperature,
                                                           minTemperature: minTemperature,
                                                           maxTemperature: maxTemperature,
                                                           image: image)
            self.viewController?.displayWeather(viewModel: viewModel)
        }
    }
}
