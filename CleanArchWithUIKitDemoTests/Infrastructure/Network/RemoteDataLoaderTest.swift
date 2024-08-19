//
//  RemoteDataLoaderTest.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/8/16.
//

@testable import CleanArchWithUIKitDemo
import Foundation
import Testing

@Suite("Remote Data Loader Tests")
struct RemoteDataLoaderTest {
    @Test
    func `init`() async {
        let (_, client) = makeSUT(url: anyURL())
        let requestedURLs = await client.requestedURLs
        #expect(requestedURLs.isEmpty)
    }

    @Test
    func requestsDataFromURL() async throws {
        let apiConfig = anyApiConfig()
        guard let url = getURL(from: apiConfig) else {
            Issue.record("invalid URL")
            return
        }
        let (sut, client) = makeSUT(url: url)

        let _: TestResult = await sut.load(config: apiConfig)

        let requestedURLs = await client.requestedURLs
        #expect(requestedURLs == [url])
    }

    @Test
    func loadTwice_requestsDataFromURLTwice() async {
        let apiConfig = anyApiConfig()
        guard let url = getURL(from: apiConfig) else {
            Issue.record("invalid URL")
            return
        }
        let (sut, client) = makeSUT(url: url)

        let _: TestResult = await sut.load(config: apiConfig)
        let _: TestResult = await sut.load(config: apiConfig)

        let requestedURLs = await client.requestedURLs
        #expect(requestedURLs == [url, url])
    }

    @Test("No connectivity")
    func load_deliversErrorOnClientError() async {
        let apiConfig = anyApiConfig()
        guard let url = getURL(from: apiConfig) else {
            Issue.record("invalid URL")
            return
        }
        let (sut, client) = makeSUT(url: url)
        let expectedError = DataLoaderError.invalidRequest
        let request = getURLRequest(sut, from: apiConfig)

        await expect(sut, config: apiConfig, toCompleteWith: failure(expectedError)) {
            await client.call(for: request, with: expectedError)
        }
    }

    @Test("Invalid data")
    func load_deliversErrorOnNon200HTTPResponse() async {
        let apiConfig = anyApiConfig()
        guard let url = getURL(from: apiConfig) else {
            Issue.record("invalid URL")
            return
        }
        let (sut, client) = makeSUT(url: url)
        let request = getURLRequest(sut, from: apiConfig)

        let samples: [Int: HTTPClientError] = [199: .informationalStatus(199), 300: .redirectStatus(300), 400: .clientError(400), 500: .serverError(500), 1000: .unexpectedStatusCode(1000)]

        for (code, error) in samples {
            await expect(sut, config: apiConfig, toCompleteWith: failure(error)) {
                await client.call(for: request, withStatusCode: code, data: makeItemJSON([:]))
            }
        }
    }

    @Test("happy path")
    func load_deliversErrorOn200HTTPResponseWithInvalidJSON() async {
        let apiConfig = anyApiConfig()
        guard let url = getURL(from: apiConfig) else {
            Issue.record("invalid URL")
            return
        }
        let (sut, client) = makeSUT(url: url)
        let request = getURLRequest(sut, from: apiConfig)

        await expect(sut, config: apiConfig, toCompleteWith: failure(CommonError.decodingError(NSError(domain: "", code: 0)))) {
            await client.call(for: request, withStatusCode: 200, data: anyData())
        }
    }

    @Test
    func load_deliversItemsOn200HTTPResponseWithJSONItems() async {
        let apiConfig = anyApiConfig()
        guard let url = getURL(from: apiConfig) else {
            Issue.record("invalid URL")
            return
        }
        let (sut, client) = makeSUT(url: url)
        let request = getURLRequest(sut, from: apiConfig)
        let (model, jsonData) = makeItem(name: "test")

        await expect(sut, config: apiConfig, toCompleteWith: .success(model)) {
            await client.call(for: request, withStatusCode: 200, data: jsonData)
        }
    }
}

// MARK: - Helpers

private extension RemoteDataLoaderTest {
    typealias TestResult = Result<TestItem, Error>

    func makeSUT(url: URL, file: StaticString = #filePath, line: UInt = #line) -> (sut: DataServiceLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteDataLoader(client: client)
        return (sut, client)
    }

    func makeItem(name: String? = nil) -> (model: TestItem, jsonData: Data) {
        let item = TestItem(name: name)

        let json = [
            "id": item.id.uuidString,
            "name": name,
        ].reduce(into: [String: Any]()) { newDictionary, element in
            if let value = element.value {
                newDictionary[element.key] = value
            }
        }

        return (item, makeItemJSON(json))
    }

    func makeItemJSON(_ item: [String: Any]) -> Data {
        try! JSONSerialization.data(withJSONObject: item)
    }

    func failure(_ error: Error) -> TestResult {
        .failure(error)
    }

    func expect(_ sut: DataServiceLoader, config: ApiConfig, toCompleteWith expectResult: TestResult, when action: () async -> Void, file: StaticString = #filePath, line: UInt = #line) async {
        await action()

        let receivedResult: TestResult = await sut.load(config: config)

        switch (receivedResult, expectResult) {
        case let (.success(receivedItem), .success(expectItem)):
            #expect(receivedItem == expectItem)

        case let (.failure(receivedError as AppError), .failure(expectError as AppError)):
            if case CommonError.decodingError = receivedError, case CommonError.decodingError = expectError {
                #expect(true)
            } else {
                #expect(receivedError.errorDescription == expectError.errorDescription)
            }

        default:
            Issue.record("Expected result \(expectResult) got \(receivedResult) instead")
        }
    }

    func anyApiConfig() -> ApiConfig {
        TestApi()
    }

    func getURLComponents(from config: ApiConfig) -> URLComponents {
        var components: URLComponents = .init()
        components.scheme = "https"
        components.host = config.host
        components.path = config.path
        return components
    }

    func getURL(from config: ApiConfig) -> URL? {
        getURLComponents(from: config).url
    }

    func getURLRequest(_ sut: DataServiceLoader, from config: ApiConfig) -> URLRequest {
        sut.combineRequest(with: config) ?? URLRequest(url: getURL(from: config)!)
    }
}

// MARK: - Test struct

private extension RemoteDataLoaderTest {
    struct TestItem: Equatable, Decodable {
        init(id: UUID = UUID(), name: String?) {
            self.id = id
            self.name = name
        }

        public let id: UUID
        public let name: String?
    }

    struct TestApi: ApiConfig {
        var host = "any-url.com"
        var path = "/path"
        var method: HTTPRestfulType = .get
        var headers: [String: String]? = ["Content-Type": "application/json"]
        var queryParameters: [String: String]? = ["queryKey": "queryValue"]
        var bodyParamaters: [String: String]? = ["bodyKey": "bodyValue"]
    }
}

private actor HTTPClientSpy: HTTPClient {
    private var results: [URLRequest: [HTTPClient.HTTPResult]] = [:]

    var requestedURLs: [URL] {
        results.flatMap { request, history in
            Array(repeating: request.url ?? anyURL(), count: history.count)
        }
    }

    enum HTTPClientSpyError: Error {
        case invalidData
    }

    func get(from url: URL) async -> HTTPClient.HTTPResult {
        await get(for: URLRequest(url: url))
    }

    func get(for request: URLRequest) async -> HTTPClient.HTTPResult {
        let currentResult: HTTPClient.HTTPResult = results[request]?.last ?? .failure(HTTPClientSpyError.invalidData)

        results[request, default: []].append(currentResult)
        return currentResult
    }

    func call(for request: URLRequest, with error: Error) {
        results[request, default: []].append(.failure(error))
    }

    func call(for request: URLRequest, withStatusCode code: Int, data: Data) {
        guard let url = request.url else {
            return
        }
        let result = parseData((data: data, response: HTTPURLResponse(url: url, statusCode: code)))
        results[request, default: []].append(result)
    }
}
