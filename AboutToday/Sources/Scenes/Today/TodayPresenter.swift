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
        DispatchQueue.main.async { [weak self] in
        }
    }
}
