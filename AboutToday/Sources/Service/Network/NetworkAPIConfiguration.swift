//
//  NetworkAPIConfiguration.swift
//  AboutToday
//
//  Created by Doyoung on 2023/01/31.
//

import Foundation

protocol NetworkAPIConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

struct NetworkAPIConfiguration: NetworkAPIConfigurable {
    
    var baseURL: URL
    var headers: [String : String]
    var queryParameters: [String : String]
    
    init(baseURL: URL, headers: [String : String] = [:], queryParameters: [String : String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
