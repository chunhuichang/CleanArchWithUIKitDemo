//
//  RemoteDataLoader.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/7/31.
//

import Foundation

public final class RemoteDataLoader: DataServiceLoader {
    private let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    public func load<T: Decodable>(config: ApiConfig) async -> DataLoaderResult<T> {
        guard let request = combineRequest(with: config) else {
            return .failure(DataLoaderError.invalidRequest)
        }

        let clientResult = await client.get(for: request)
        switch clientResult {
        case .success(let data):
            do {
                let result = try JSONDecoder().decode(T.self, from: data.data)
                return .success(result)
            } catch {
                return .failure(CommonError.decodingError(error))
            }

        case .failure(let error):
            return .failure(error)
        }
    }
}

extension Dictionary {
    func retriveData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self)
        } catch {
            return "".data(using: .utf8) ?? Data()
        }
    }
}
