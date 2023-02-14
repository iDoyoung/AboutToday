//
//  TodayPresenter.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/02.
//

import UIKit
import MapKit
import Photos

protocol TodayPresenting {
    func presentWeather(response: TodayWeather.Fetched.Response)
    func presentCurrentLocation(_ location: CLLocation)
    func presentLocationError()
    func presentPhotos(response: [PhotoImage.Fetched.Response])
}

final class TodayPresenter: TodayPresenting {
    
    weak var viewController: TodayDisplayLogic?
    private let span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
    
    func presentCurrentLocation(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        viewController?.displayCurrentLocation(region: region)
    }
    
    func presentWeather(response: TodayWeather.Fetched.Response) {
        DispatchQueue.main.async {
            let city = response.city
            let currentTemperature = "\(Int(response.temp.rounded()))º"
            let minTemperature = "최저:\(Int(response.minTemp.rounded()))º"
            let maxTemperature = "최고:\(Int(response.maxTemp.rounded()))º"
            let image = UIImage(data: response.imageData)?.withRenderingMode(.alwaysOriginal)
            let viewModel = TodayWeather.Fetched.ViewModel(city: city,
                                                           currentTemperature: currentTemperature,
                                                           minTemperature: minTemperature,
                                                           maxTemperature: maxTemperature,
                                                           image: image)
            self.viewController?.displayWeather(viewModel: viewModel)
        }
    }
    
    func presentLocationError() {
        viewController?.displayLocationError()
    }
    
    func presentPhotos(response: [PhotoImage.Fetched.Response]) {
        let images = response.map(\.image)
        let viewModel = PhotoImage.Fetched.ViewModel(images: images)
        viewController?.displayPhotos(viewModel: viewModel)
    }
}
