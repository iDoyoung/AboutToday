//
//  WeatherDetailViewController.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/14.
//

import UIKit

protocol WeatherDetailDisplayLogic: AnyObject {
    func displayWeather(viewModel: WeatherDetail.Loaded.ViewModel)
}
    
final class WeatherDetailViewController: ViewController, WeatherDetailDisplayLogic {
    var interactor: (WeatherDetailBusinessLogic&WeatherDetailDataStore)?
    var router: WeatherDetailDataPassing?
    //MARK: - UI Properties
    var contentView = WeatherDetailView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.loadWeatherDetail()
    }
    
    //MARK: - Display Logic
    func displayWeather(viewModel: WeatherDetail.Loaded.ViewModel) {
        contentView.cityLabel.text = viewModel.city
        contentView.currentTempLabel.text = viewModel.currentTemperature
        contentView.maxTempLabel.text = viewModel.maxTemperature
        contentView.minTempLabel.text = viewModel.minTemperature
        contentView.descriptionLabel.text = viewModel.description
        contentView.feelsLikeLabel.text = viewModel.feelsLike
        contentView.humidityLabel.text = viewModel.humidity
        contentView.pressureLabel.text = viewModel.pressure
    }
}
