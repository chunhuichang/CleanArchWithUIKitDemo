//
//  SharedTestHelpers.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/8/17.
//

import Foundation

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    Data("any data".utf8)
}

func anyURLRequest() -> URLRequest {
    URLRequest(url: anyURL())
}

func anyHTTPURLResponse() -> HTTPURLResponse {
    HTTPURLResponse(statusCode: 200)
}

func nonHTTPURLResponse() -> URLResponse {
    URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode)
    }

    convenience init(url: URL, statusCode: Int) {
        self.init(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
