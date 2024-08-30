//
//  ExchangeRateListViewModelTests.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/8/21.
//

import CleanArchWithUIKitDemo
import Combine
import XCTest

class ExchangeRateListViewModelTests: XCTestCase {
    func test_errorDataTrigger_failureExchangeRateListAlertError() async {
        let predicateError = anyNSError()
        var (sut, cancellable) = makeSUT(result: .failure(predicateError))

        let exp = expectation(description: "Wait for ExchangeRateList")

        sut.$alertMessage
            .dropFirst()
            .sink { message in
                XCTAssertNotNil(message)
                XCTAssertEqual(message?.title, "Error")
                XCTAssertEqual(message?.message, predicateError.localizedDescription)
                exp.fulfill()
            }
            .store(in: &cancellable)
        sut.viewDidLoad()
        await fulfillment(of: [exp])
    }

    func test_correctDataTrigger_successExchangeRateListGetEntity() async {
        let baseCurrency = Currency.USD
        let predicateEntity = ExchangeRateEntity.mockValue
        var (sut, cancellable) = makeSUT(result: .success(predicateEntity))

        let exp = expectation(description: "Wait for ExchangeRateList")

        sut.$rateEntity
            .dropFirst()
            .sink(receiveCompletion: { _ in
                XCTFail("Expected success, got \(predicateEntity) instead")
            }, receiveValue: { entity in
                XCTAssertEqual(entity?.base, predicateEntity.base)
                XCTAssertEqual(entity?.date, predicateEntity.date)
                XCTAssertEqual(entity?.timeLastUpdated, predicateEntity.timeLastUpdated)
                XCTAssertEqual(entity?.rates.count, predicateEntity.rates.count)
                XCTAssertEqual(entity?.getRate(with: baseCurrency), predicateEntity.getRate(with: baseCurrency))
                exp.fulfill()
            })
            .store(in: &cancellable)
        sut.viewDidLoad()
        await fulfillment(of: [exp])
    }
}

private extension ExchangeRateListViewModelTests {
    func makeSUT(result: Result<ExchangeRateEntity, Error>, file: StaticString = #filePath, line: UInt = #line) -> (vm: ExchangeRateListViewModel, cancellable: Set<AnyCancellable>) {
        let usecase = MockUseCase(result: result)
        let vm = ExchangeRateListViewModel(usecase)
        trackForMemoryLeaks(vm)
        return (vm, Set<AnyCancellable>())
    }
}

private struct MockUseCase: ExchangeRateListUseCase {
    private let result: Result<ExchangeRateEntity, Error>

    init(result: Result<ExchangeRateEntity, Error>) {
        self.result = result
    }

    func exchangeRateList(with base: Currency) async -> Result<ExchangeRateEntity, any Error> {
        result
    }
}
