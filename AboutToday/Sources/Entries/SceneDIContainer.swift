//
//  SceneDIContainer.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/03.
//

import Foundation

final class SceneDIContainer {
    
    private func makeWeatherService() -> NetworkDataCodableService {
        let configuration = NetworkAPIConfiguration(baseURL: getOpenWeatherBaseURL(isAPI: true), queryParameters: [ConfidentialKey.openWeatherAPI.key: ConfidentialKey.openWeatherAPI.value, "units": "metric"])
        let service = NetworkService(configuration: configuration)
        return NetworkDataCodableService(network: service)
    }
    
    private func makeWeatherIconImageService() -> NetworkService {
        let configuration = NetworkAPIConfiguration(baseURL: getOpenWeatherBaseURL(isAPI: false))
        return NetworkService(configuration: configuration)
    }
    
    private func makeWeatherWorker() -> WeatherWorker {
        let weatherRepository = DefaultWeatherRepository(service: makeWeatherService())
        let wetherIconRepository = DefaultWeatherIconRepository(service: makeWeatherIconImageService())
        return WeatherWorker(weatherRepository: weatherRepository, weatherIconRepository: wetherIconRepository)
    }
    
    private func makePhotosWorker() -> PhotosWorker {
        let photosRepository = DefaultPhotosRepository(service: PhotosService())
        return PhotosWorker(photosRepository: photosRepository)
    }
    
    //MARK: - Today Scene
    func makeTodayViewController() -> TodayViewController {
        let viewController = TodayViewController()
        let presenter = makeTodayPresenter(with: viewController)
        let interactor = makeTodayInteractor(with: presenter)
        let router = makeTodayRouter(with: viewController)
        router.dataStore = interactor
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
    
    private func makeTodayInteractor(with presenter: TodayPresenter) -> TodayInteractor {
        let interactor = TodayInteractor(weatherWorker: makeWeatherWorker(), photosWorker: makePhotosWorker())
        interactor.presenter = presenter
        return interactor
    }
    
    private func makeTodayPresenter(with viewController: TodayViewController) -> TodayPresenter {
        let presenter = TodayPresenter()
        presenter.viewController = viewController
        return presenter
    }
    
    private func makeTodayRouter(with viewController: TodayViewController) -> TodayRouter {
        let router = TodayRouter()
        router.sceneContainer = self
        router.viewController = viewController
        return router
    }
    
    //MARK: - Weather Detail Scene
    func makeWeatherDetailViewController() -> WeatherDetailViewController {
        let viewController = WeatherDetailViewController()
        let presenter = makeWeatherDetailPresenter(with: viewController)
        let interactor = makeWeatherDetailInteractor(with: presenter)
        let router = makeWeatherDetailRouter(with: viewController)
        router.dataStore = interactor
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
    
    private func makeWeatherDetailInteractor(with presenter: WeatherDetailPresenter) -> WeatherDetailInteractor {
        let interactor = WeatherDetailInteractor()
        interactor.presenter = presenter
        return interactor
    }
    
    private func makeWeatherDetailPresenter(with viewController: WeatherDetailViewController) -> WeatherDetailPresenter {
        let presenter = WeatherDetailPresenter()
        presenter.viewController = viewController
        return presenter
    }
    
    private func makeWeatherDetailRouter(with viewController: WeatherDetailViewController) -> WeatherDetailRouter {
        let router = WeatherDetailRouter()
        router.viewController = viewController
        return router
    }
}

extension SceneDIContainer {
    
    enum ConfidentialKey {
        enum openWeatherAPI {
            static let key = "appid"
            static let value = getAppID()
        }
        
        private static func getAppID() -> String {
            guard let appID = Bundle.main.object(forInfoDictionaryKey: "Weather_api_key") as? String else {
                fatalError("Weather_api_key must not be empty")
            }
            return appID
        }
    }
    
    private func getOpenWeatherBaseURL(isAPI: Bool) -> URL {
        guard let provided = Bundle.main.object(forInfoDictionaryKey: "Weather_api_base_url") as? String else {
            fatalError("Weather_api_base_url must not be empty")
        }
        if isAPI {
            return URL(string: "api." + provided)!
        } else {
            return URL(string: provided)!
        }
    }
}

