//
//  Seeds.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/02.
//

import XCTest
import CoreLocation
@testable import AboutToday

enum Seeds {
    enum Dummy {
        static let weather = Weather(id: 0,
                                     city: "",
                                     main: .init(temp: 0, feels: 0, minTemp: 0, maxTemp: 0, pressure: 0, humidity: 0),
                                     weather: [Weather.Weather(description: "", icon: "")],
                                     wind: .init(speed: 0),
                                     coordinate: .init(longitude: 100, latitude: 100))
        static let todayWeatherResponse = TodayWeather.Fetched.Response(city: "",
                                                                        temp: 0,
                                                                        minTemp: 0,
                                                                        maxTemp: 0,
                                                                        imageData: UIImage(systemName: "trash")!.pngData()!)
        
        static let responseOfWeatherDetail = WeatherDetail.Loaded.Response(city: "New York", temp: 0, minTemp: 0, maxTemp: 0, description: "Snow", feelsLike: 0, humidity: 0, pressure: 0)
        
        static let responseOfPhotosLocation = PhotosLocation.Loaded.Response(locations: [CLLocation()])
    }
}
