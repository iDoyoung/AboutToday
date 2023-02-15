//
//  TodayRouter.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import UIKit

protocol TodayRouting {
    func routeToWeatherDetail()
}

protocol TodayDataPassing {
}

final class TodayRouter: TodayRouting, TodayDataPassing {
    
    weak var viewController: TodayViewController?
    var sceneContainer: SceneDIContainer?
    
    func routeToWeatherDetail() {
        guard let destinationViewController = sceneContainer?.makeWeatherDetailViewController() else { return }
        viewController?.show(destinationViewController, sender: nil)
    }
}
