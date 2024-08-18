//
//  ApiConfig.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/7/31.
//

import Foundation

public enum HTTPRestfulType: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public protocol ApiConfig {
    var host: String { get }
    var path: String { get set }
    var method: HTTPRestfulType { get }
    var headers: [String: String]? { get set }
    var queryParameters: [String: String]? { get set }
    var bodyParamaters: [String: String]? { get set }
}
