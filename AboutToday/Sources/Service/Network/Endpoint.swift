//
//  Endpoint.swift
//  AboutToday
//
//  Created by Doyoung on 2023/01/31.
//

import Foundation

struct Endpoint<R>: Requester {
    
    typealias Response = R
    
    var path: String
    var isFullPath: Bool
    var method: HTTPMethodType
    var headerParameters: [String : String]
    var queryParameters: [String : String]
    var bodyParameters: [String : Any]
    
    init(path: String, isFullPath: Bool = false, method: HTTPMethodType = .get, headerParameters: [String: String] = [:], queryParameters: [String: String] = [:], bodyParameters: [String: Any] = [:]) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
    }
}
