//
//  CleanArchWithUIKitDemoTests.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/7/31.
//

@testable import CleanArchWithUIKitDemo
import Foundation
import Testing

@Suite("URLSession implement HTTPClient")
struct URLSessionHTTPClientTests {
    @Test
    func getForRequest_failsOnRequestError() async {
        let requestError = anyNSError()
        let receivedError = await resultErrorFor((data: nil, response: nil, error: requestError), clientGetType: .request) as NSError?

        #expect(receivedError?.domain == requestError.domain)
        #expect(receivedError?.code == requestError.code)
    }

    @Test
    func getForRequest_succeedsOnHTTPURLResponseWithData() async {
        let data = anyData()
        let response = anyHTTPURLResponse()

        let receivedValues = await resultValuesFor((data: data, response: response, error: nil), clientGetType: .request)

        #expect(receivedValues?.data == data)
        #expect(receivedValues?.response.url == response.url)
        #expect((receivedValues?.response as? HTTPURLResponse)?.statusCode == response.statusCode)
    }

    @Test(arguments: [100, 300, 400, 500, 600])
    func getForRequest_failsOnAllInvalidStatusCodeCases(statusCode: Int) async {
        await expectErrorAssertNotNil(resultErrorFor((data: anyData(), response: HTTPURLResponse(statusCode: statusCode), error: nil), clientGetType: .request))
    }

    @Test
    func getForRequest_failsOnAllInvalidRepresentationCases() async {
        await expectErrorAssertNotNil(resultErrorFor((data: nil, response: nil, error: nil), clientGetType: .request))
        await expectErrorAssertNotNil(resultErrorFor((data: nil, response: nonHTTPURLResponse(), error: nil), clientGetType: .request))
        await expectErrorAssertNotNil(resultErrorFor((data: anyData(), response: nil, error: nil), clientGetType: .request))
        await expectErrorAssertNotNil(resultErrorFor((data: anyData(), response: nil, error: anyNSError()), clientGetType: .request))
        await expectErrorAssertNotNil(resultErrorFor((data: nil, response: nonHTTPURLResponse(), error: anyNSError()), clientGetType: .request))
        await expectErrorAssertNotNil(resultErrorFor((data: nil, response: anyHTTPURLResponse(), error: anyNSError()), clientGetType: .request))
        await expectErrorAssertNotNil(resultErrorFor((data: anyData(), response: nonHTTPURLResponse(), error: anyNSError()), clientGetType: .request))
        await expectErrorAssertNotNil(resultErrorFor((data: anyData(), response: anyHTTPURLResponse(), error: anyNSError()), clientGetType: .request))
        await expectErrorAssertNotNil(resultErrorFor((data: anyData(), response: nonHTTPURLResponse(), error: nil), clientGetType: .request))
    }

    @Test
    func getFromURL_failsOnRequestError() async {
        let requestError = anyNSError()
        let receivedError = await resultErrorFor((data: nil, response: nil, error: requestError)) as NSError?

        #expect(receivedError?.domain == requestError.domain)
        #expect(receivedError?.code == requestError.code)
    }

    @Test
    func getFromURL_succeedsOnHTTPURLResponseWithData() async {
        let data = anyData()
        let response = anyHTTPURLResponse()

        let receivedValues = await resultValuesFor((data: data, response: response, error: nil))

        #expect(receivedValues?.data == data)
        #expect(receivedValues?.response.url == response.url)
        #expect((receivedValues?.response as? HTTPURLResponse)?.statusCode == response.statusCode)
    }

    @Test
    func getFromURL_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() async {
        let emptyData = Data()
        let response = anyHTTPURLResponse()

        let receivedValues = await resultValuesFor((data: emptyData, response: response, error: nil))

        #expect(receivedValues?.data == emptyData)
        #expect(receivedValues?.response.url == response.url)
        #expect((receivedValues?.response as? HTTPURLResponse)?.statusCode == response.statusCode)
    }

    @Test
    func getFromURL_failsOnAllInvalidRepresentationCases() async {
        await expectErrorAssertNotNil(resultErrorFor((data: nil, response: nil, error: nil)))
        await expectErrorAssertNotNil(resultErrorFor((data: nil, response: nonHTTPURLResponse(), error: nil)))
        await expectErrorAssertNotNil(resultErrorFor((data: anyData(), response: nil, error: nil)))
        await expectErrorAssertNotNil(resultErrorFor((data: anyData(), response: nil, error: anyNSError())))
        await expectErrorAssertNotNil(resultErrorFor((data: nil, response: nonHTTPURLResponse(), error: anyNSError())))
        await expectErrorAssertNotNil(resultErrorFor((data: nil, response: anyHTTPURLResponse(), error: anyNSError())))
        await expectErrorAssertNotNil(resultErrorFor((data: anyData(), response: nonHTTPURLResponse(), error: anyNSError())))
        await expectErrorAssertNotNil(resultErrorFor((data: anyData(), response: anyHTTPURLResponse(), error: anyNSError())))
        await expectErrorAssertNotNil(resultErrorFor((data: anyData(), response: nonHTTPURLResponse(), error: nil)))
    }

    @Test(arguments: [100, 300, 400, 500, 600])
    func getFromURL_failsOnAllInvalidStatusCodeCases(statusCode: Int) async {
        await expectErrorAssertNotNil(resultErrorFor((data: anyData(), response: HTTPURLResponse(statusCode: statusCode), error: nil)))
    }
}

// MARK: - Helpers

private extension URLSessionHTTPClientTests {
    enum GetType {
        case url, request
    }

    func makeSUT(_ values: (data: Data?, response: URLResponse?, error: Error?)?, file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        URLSessionHTTPClient(session: URLSessionMock(values))
    }

    func resultFor(_ values: (data: Data?, response: URLResponse?, error: Error?)?, clientGetType: GetType = .url, file: StaticString = #filePath, line: UInt = #line) async -> HTTPClient.HTTPResult {
        let sut = makeSUT(values)
        switch clientGetType {
        case .url:
            return await sut.get(from: anyURL())
        case .request:
            return await sut.get(for: anyURLRequest())
        }
    }

    func resultErrorFor(_ values: (data: Data?, response: URLResponse?, error: Error?)?, clientGetType: GetType = .url, file: StaticString = #filePath, line: UInt = #line) async -> Error? {
        let result = await resultFor(values, clientGetType: clientGetType)

        switch result {
        case .failure(let error):
            return error
        default:
            Issue.record("Expected failure, got \(result) instead")
            return nil
        }
    }

    func resultValuesFor(_ values: (data: Data?, response: URLResponse?, error: Error?), clientGetType: GetType = .url, file: StaticString = #filePath, line: UInt = #line) async -> (data: Data, response: URLResponse)? {
        let result = await resultFor(values, clientGetType: clientGetType)

        switch result {
        case .success(let values):
            return values
        default:
            Issue.record("Expected success, got \(result) instead")
            return nil
        }
    }

    func expectErrorAssertNotNil(_ error: Error?) {
        #expect(error != nil)
    }
}

struct URLSessionMock: URLSessionProtocol {
    let result: HTTPClient.HTTPResult

    init(_ values: (data: Data?, response: URLResponse?, error: Error?)?) {
        if let error = values?.error {
            result = .failure(error)
        } else {
            guard let data = values?.data, let response = values?.response else {
                result = .failure(URLError(.unknown))
                return
            }
            result = .success((data: data, response: response))
        }
    }

    func data(from url: URL) async throws -> (Data, URLResponse) {
        try parseResult()
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try parseResult()
    }

    private func parseResult() throws -> (Data, URLResponse) {
        switch result {
        case .success((let data, let response)):
            return (data, response)
        case .failure(let error):
            throw error
        }
    }
}
