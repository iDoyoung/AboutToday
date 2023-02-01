//
//  APIEndpoints.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/01.
//

import Foundation

struct APIEndpoints {
    
    static func getCurrentLocation(latitude: String, longitude: String) -> Endpoint<Weather> {
        return Endpoint(path: "weather?", queryParameters: ["lat": latitude, "lon": longitude])
    }
}
