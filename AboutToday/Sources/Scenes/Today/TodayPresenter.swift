//
//  TodayPresenter.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import UIKit

protocol TodayPresenting {
    func presentWeatherIcon(response: Data)
}

final class TodayPresenter: TodayPresenting {
    
    weak var viewController: TodayDisplayLogic?
    
    func presentWeatherIcon(response: Data) {
        guard let image = UIImage(data: response) else { return }
        viewController?.displayNavigationBarLeftItem(weather: image)
    }
}
