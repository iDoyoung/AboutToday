//
//  TodayPresenter.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import UIKit
import MapKit

protocol TodayPresenting {
    func presentWeather(response: TodayWeather.Fetched.Response)
    func presentCurrentLocation(_ location: CLLocation)
}

final class TodayPresenter: TodayPresenting {
    
    weak var viewController: TodayDisplayLogic?
    private let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    
    func presentCurrentLocation(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        viewController?.displayCurrentLocation(region: region)
    }
    
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
