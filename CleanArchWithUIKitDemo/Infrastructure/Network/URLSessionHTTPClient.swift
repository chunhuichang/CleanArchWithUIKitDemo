//
//  URLSessionHTTPClient.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/9.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

public class URLSessionHTTPClient: HTTPClient {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    public func get(from url: URL) async -> HTTPResult {
        do {
            return try await parseData(session.data(from: url))
        } catch {
            return .failure(error)
        }
    }

    public func get(for request: URLRequest) async -> HTTPResult {
        do {
            return try await parseData(session.data(for: request))
        } catch {
            return .failure(error)
        }
    }

    private func parseData(_ data: HTTPClientData) async -> HTTPResult {
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
