//
//  AppDIContainer.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/23.
//

import UIKit

public final class AppDIContainer {
    // MARK: - Network

    let loadDataLoader = RemoteDataLoader(client: URLSessionHTTPClient())
}
