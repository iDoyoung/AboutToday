//
//  Seeds.swift
//  AboutTodayTests
//
//  Created by Doyoung on 2023/02/02.
//

import XCTest
@testable import AboutToday

enum Seeds {
    enum Dummy {
        static let weather = Weather(id: 0,
                                     city: "",
                                     main: .init(temp: 0, feels: 0, minTemp: 0, maxTemp: 0, pressure: 0, humidity: 0),
                                     weather: [Weather.Weather(description: "", icon: "")],
                                     wind: .init(speed: 0),
                                     coordinate: .init(longitude: 100, latitude: 100))
    }
}
