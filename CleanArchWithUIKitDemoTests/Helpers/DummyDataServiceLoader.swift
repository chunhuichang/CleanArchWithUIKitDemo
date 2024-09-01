//
//  DummyDataServiceLoader.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/9/1.
//

import CleanArchWithUIKitDemo
import Foundation

public struct DummyDataServiceLoader: DataServiceLoader {
    public func load<T: Decodable>(config: ApiConfig) async -> DataLoaderResult<T> {
        .failure(NSError(domain: "DummyDataServiceLoader", code: 0, userInfo: nil))
    }
}
