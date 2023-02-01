//
//  NetworkCodableService.swift
//  AboutToday
//
//  Created by Doyoung on 2023/02/01.
//

import Foundation

enum NetworkDataCodableError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
}

protocol NetworkDataCodableServiceProtocol {
    func request<T: Decodable, E: ResponseRequester>(with endpoint: E) async throws -> T where T == E.Response
    func request<E: ResponseRequester>(with endpoint: E) async throws -> Void
}

final class NetworkDataCodableService: NetworkDataCodableServiceProtocol {
    
    private let network: NetworkServiceProtocol
    
    init(network: NetworkServiceProtocol) {
        self.network = network
    }
    
    func request<T: Decodable, E: ResponseRequester>(with endpoint: E) async throws -> T where T == E.Response {
        let data = try await network.request(endpoint: endpoint)
        let response: T = try decode(data: data)
        return response
    }
    
    func request<E: ResponseRequester>(with endpoint: E) async throws -> Void {
        let response = try await network.request(endpoint: endpoint)
        return
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        do {
            let result: T = try JSONResponseDecoder().decode(data)
            return result
        } catch {
            throw NetworkDataCodableError.parsing(error)
        }
    }
}

final class JSONResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    init() { }
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
