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
    var dataStore: TodayDataStore? { get }
}

final class TodayRouter: TodayRouting, TodayDataPassing {
    
    weak var viewController: TodayViewController?
    var dataStore: TodayDataStore?
    var sceneContainer: SceneDIContainer?
    
    func routeToWeatherDetail() {
        guard let destinationViewController = sceneContainer?.makeWeatherDetailViewController() else { return }
        var destinationDataStore = destinationViewController.router?.dataStore
        destinationDataStore?.weather = dataStore?.weather
        viewController?.show(destinationViewController, sender: nil)
    }
    
    func routeToDetailMap() {
        guard let desinationViewController = sceneContainer?.makeDetailMapViewController() else { return }
        var destinationDataStore = desinationViewController.router?.dataStore
        destinationDataStore?.assets = dataStore?.fetchedPhotosAsset
        viewController?.show(desinationViewController, sender: nil)
    }
}
