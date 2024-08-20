//
//  URLSessionHTTPClient.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/9.
//

import Foundation

public protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

public class URLSessionHTTPClient: HTTPClient {
    private let session: URLSessionProtocol

    public init(session: URLSessionProtocol = URLSession.shared) {
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
}
