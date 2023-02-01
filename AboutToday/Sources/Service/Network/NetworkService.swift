//
//  NetworkService.swift
//  AboutToday
//
//  Created by Doyoung on 2023/01/31.
//

import Foundation

enum NetworkError: Error {
    case notConnectedInternet
    case badURL
    case timeOut
    case unexpected(Error)
}

protocol NetworkServiceProtocol {
    func request(endpoint: Requester) async throws -> Data
}

protocol NetworkSessionDataProtocol {
    func request(_ request: URLRequest) async throws -> (Data, URLResponse)
}

final class NetworkSessionData: NetworkSessionDataProtocol {
    
    func request(_ request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await URLSession.shared.data(for: request)
        } catch {
            throw error
        }
    }
}

final class NetworkService: NetworkServiceProtocol {
    
    let configuration: NetworkAPIConfigurable
    let sessionData: NetworkSessionDataProtocol
    
    init(configuration: NetworkAPIConfigurable, sessionData: NetworkSessionDataProtocol = NetworkSessionData()) {
        self.configuration = configuration
        self.sessionData = sessionData
    }
    
    func request(endpoint: Requester) async throws -> Data {
        let urlRequest = try? endpoint.requestURL(with: configuration)
        guard let urlRequest else { throw NetworkError.badURL }
        
        do {
            return try await request(request: urlRequest)
        } catch {
            throw error
        }
    }
    
    private func request(request: URLRequest) async throws -> Data {
        do {
            let (data, _) = try await sessionData.request(request)
            return data
        } catch {
           throw resolve(error: error)
        }
    }
    
    private func resolve(error: Error) -> NetworkError {
        let errorCode = URLError.Code(rawValue: (error as NSError).code)
        switch errorCode {
        case .notConnectedToInternet: return .notConnectedInternet
        case .timedOut: return .timeOut
        case .badURL: return .badURL
        default:
            return .unexpected(error)
        }
    }
}