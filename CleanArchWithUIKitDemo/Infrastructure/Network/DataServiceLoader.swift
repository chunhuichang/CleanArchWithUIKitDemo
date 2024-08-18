//
//  DataServiceLoader.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/9.
//

import Foundation

public enum DataLoaderError: AppError {
    case invalidRequest

    public var errorDescription: String {
        switch self {
        case .invalidRequest: "Invalid Request"
        }
    }
}

public protocol DataServiceLoader {
    typealias DataLoaderResult<T> = Result<T, Error>

    func load<T: Decodable>(config: ApiConfig) async -> DataLoaderResult<T>
}

extension DataServiceLoader {
    func combineRequest(with config: ApiConfig) -> URLRequest? {
        var components: URLComponents = .init()
        components.scheme = "https"
        components.host = config.host
        components.path = config.path

        guard let url = components.url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = config.method.rawValue

        config.headers?.forEach { request.addValue($1, forHTTPHeaderField: $0) }

        if let apiParams = config.queryParameters, !apiParams.isEmpty {
            components.queryItems = apiParams.map { URLQueryItem(name: $0, value: $1) }
        }

        if let apiParams = config.bodyParamaters, !apiParams.isEmpty {
            request.httpBody = apiParams.retriveData()
        }

        return request
    }
}
