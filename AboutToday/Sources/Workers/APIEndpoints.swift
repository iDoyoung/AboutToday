//
//  APIEndpoints.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/01.
//

import Foundation

struct APIEndpoints {
    
    static func getCurrentLocation(latitude: String, longitude: String) -> Endpoint<Weather> {
        return Endpoint(path: "data/2.5/weather?", queryParameters: ["lat": latitude, "lon": longitude])
    }
    
    static func getWeatherIcon(with imagePath: String) -> Endpoint<Data> {
        return Endpoint(path: "img/wn/\(imagePath)@2x.png")
    }
}
