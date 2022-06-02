//
//  APIRequest.swift
//  GuideProject_Habits
//
//  Created by Tomonao Hashiguchi on 2022-06-01.
//

import Foundation

protocol APIRequest{
    associatedtype Response
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var request: URLRequest { get }
    var postData: Data? { get }
}

extension APIRequest {
    var host: String { "127.0.0.1" }
    var port: Int { 8080 }
}

extension APIRequest {
    var queryItems: [URLQueryItem]? { nil }
    var postData: Data? { nil }
}

extension APIRequest {
    var request: URLRequest {
        var components = URLComponents()
        components.scheme = "http"
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = queryItems
        
        var request = URLRequest(url: components.url!)
        
        if let data = postData {
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
        }
        return request
    }
}

enum APIRequestError: Error{
    case itemNotFound
    case requestFailed
}

extension APIRequest where Response: Decodable{
    func send() async throws -> Response {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIRequestError.itemNotFound
        }
        
        // MARK: problem is here. try is always fail. data has data. so decoding problem
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(Response.self, from: data)
        return decoded
    }
}
