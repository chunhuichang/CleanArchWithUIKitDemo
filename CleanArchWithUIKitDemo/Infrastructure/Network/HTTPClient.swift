//
//  HTTPClient.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/9.
//

import Foundation

public enum HTTPClientError: CustomStringConvertible {
    case invalidURL
    case invalidResponse
    case informationalStatus(Int)
    case redirectStatus(Int)
    case clientError(Int)
    case serverError(Int)
    case unexpectedStatusCode(Int)
    case networkError(Error)

    private var rawValue: String {
        switch self {
        case .invalidURL: "Invalid URL"
        case .invalidResponse: "Invalid Response"
        case .informationalStatus: "Informational Status"
        case .redirectStatus: "Redirect Status"
        case .clientError: "Client Error"
        case .serverError: "Server Error"
        case .unexpectedStatusCode: "Unexpected Status Code"
        case .networkError: "Network Error"
        }
    }

    public var description: String {
        switch self {
        case .invalidURL, .invalidResponse:
            rawValue
        case .informationalStatus(let code), .redirectStatus(let code), .clientError(let code), .serverError(let code), .unexpectedStatusCode(let code):
            "\(rawValue): \(code)"
        case .networkError(let error):
            "\(rawValue): \(error.localizedDescription)"
        }
    }
}

extension HTTPClientError: AppError {
    public var errorDescription: String {
        description
    }
}

public protocol HTTPClient {
    typealias HTTPClientData = (data: Data, response: URLResponse)
    typealias HTTPResult = Result<HTTPClientData, Error>

    func get(from url: URL) async -> HTTPResult
    func get(for request: URLRequest) async -> HTTPResult
}

extension HTTPClient {
    func parseData(_ data: HTTPClientData) -> HTTPResult {
        guard let httpResponse = data.response as? HTTPURLResponse else {
            return .failure(HTTPClientError.invalidResponse)
        }

        switch httpResponse.statusCode {
        case 100...199:
            return .failure(HTTPClientError.informationalStatus(httpResponse.statusCode))
        case 200...299:
            return .success((data.data, httpResponse))
        case 300...399:
            return .failure(HTTPClientError.redirectStatus(httpResponse.statusCode))
        case 400...499:
            return .failure(HTTPClientError.clientError(httpResponse.statusCode))
        case 500...599:
            return .failure(HTTPClientError.serverError(httpResponse.statusCode))
        default:
            return .failure(HTTPClientError.unexpectedStatusCode(httpResponse.statusCode))
        }
    }
}
