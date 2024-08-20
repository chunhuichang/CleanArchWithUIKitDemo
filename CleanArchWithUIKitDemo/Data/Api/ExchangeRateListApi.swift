//
//  ExchangeRateListApi.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/20.
//

import Foundation

public struct ExchangeRateListApi: ApiConfig {
    public init(with base: Currency) {
        path.append(base.rawValue)
    }

    public var host: String = "api.exchangerate-api.com"
    public var path: String = "/v4/latest/"
    public var method: HTTPRestfulType = .get
    public var headers: [String: String]? = nil
    public var queryParameters: [String: String]? = nil
    public var bodyParamaters: [String: String]? = nil
}
