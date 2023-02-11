//
//  TodayViewController.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import UIKit
import MapKit

protocol TodayDisplayLogic: AnyObject {
    func displayWeather(viewModel: TodayWeather.Fetched.ViewModel)
    func displayLocationError()
    func displayCurrentLocation(region: MKCoordinateRegion)
}

final class TodayViewController: ViewController, TodayDisplayLogic {
    
    var interactor: TodayBusinessLogic?
    
    //MARK: UI Properties
    var contentView = TodayView()
    
    private lazy var navigationLeftBarButtonItem: UIBarButtonItem = {
        let barButtionItem = UIBarButtonItem(image: nil, style: .plain, target: self, action: nil)
        barButtionItem.accessibilityLabel = "Today weather"
        return barButtionItem
    }()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        interactor?.startUpdatingLocation()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.requestCurrentLocation()
    }
    //TODO: Should Call Interactor to request Location
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = navigationLeftBarButtonItem
    }
    
    //MARK: - Display Logic
    func displayCurrentLocation(region: MKCoordinateRegion) {
        contentView.currentLocationMapView.mapView.setRegion(region, animated: false)
        interactor?.loadWeather()
    }
    
    func displayLocationError() {
        contentView.currentLocationMapView.toggleMapVisibility(hide: true)
    }
    
    func displayWeather(viewModel: TodayWeather.Fetched.ViewModel) {
        assert(Thread.isMainThread, "Thread is not main")
        setLeftBarButtonItemImage(viewModel.image)
        setCityLabel(text: viewModel.city)
        setCurrentTempLabel(text: viewModel.currentTemperature)
        setMaxTempLabel(text: viewModel.maxTemperature)
        setMinTempLabel(text: viewModel.minTemperature)
        contentView.todayWeatherView.setNeedsLayout()
    }
    
    private func setLeftBarButtonItemImage(_ image: UIImage?) {
        assert(image != nil, "Image is nil")
        navigationLeftBarButtonItem.image = image
    }
    
    private func setCityLabel(text: String) {
        contentView.todayWeatherView.cityLabel.text = text
    }
    
    private func setCurrentTempLabel(text: String) {
        contentView.todayWeatherView.currentTempLabel.text = text
    }
    
    private func setMaxTempLabel(text: String) {
        contentView.todayWeatherView.maxTempLabel.text = text
    }
    
    private func setMinTempLabel(text: String) {
        contentView.todayWeatherView.minTempLabel.text = text
    }
}
