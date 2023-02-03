//
//  SceneDIContainer.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/03.
//

import Foundation

final class SceneDIContainer {
    
    private func makeWeatherService() -> NetworkDataCodableService {

        let configuration = NetworkAPIConfiguration(baseURL: getOpenWeatherBaseURL())
        let service = NetworkService(configuration: configuration)
        return NetworkDataCodableService(network: service)
    }
    
    private func makeWeatherWorker() -> WeatherWorker {
        let repository = DefaultWeatherRepository(service: makeWeatherService())
        return WeatherWorker(weatherRepository: repository)
    }
    
    func makeTodayViewController() -> TodayViewController {
        let viewController = TodayViewController()
        let presenter = makeTodayPresenter(with: viewController)
        let interactor = makeTodayInteractor(with: presenter)
        viewController.interactor = interactor
        return viewController
    }
    
    private func makeTodayInteractor(with presenter: TodayPresenter) -> TodayInteractor {
        let interactor = TodayInteractor(weatherWorker: makeWeatherWorker())
        interactor.presenter = presenter
        return interactor
    }
    
    private func makeTodayPresenter(with viewController: TodayViewController) -> TodayPresenter {
        let presenter = TodayPresenter()
        presenter.viewController = viewController
        return presenter
    }
}

extension SceneDIContainer {
    
    private func getOpenWeatherBaseURL() -> URL {
        guard let provided = Bundle.main.object(forInfoDictionaryKey: "Weather_api_base_url") as? String else {
            fatalError("Weather_api_base_url must not be empty")
        }
        let url = URL(string: provided)!
        return url
    }
}

