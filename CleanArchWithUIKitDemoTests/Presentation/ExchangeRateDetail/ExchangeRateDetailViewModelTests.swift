//
//  ExchangeRateDetailViewModelTests.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/9/1.
//

import CleanArchWithUIKitDemo
import Combine
import XCTest

class ExchangeRateDetailViewModelTests: XCTestCase {
    func test_output_currencyLabel() async {
        let predicateEntity = ExchangeRateEntity.RateEntity.mockValue
        var (sut, cancellable) = makeSUT(param: ExchangeRateDetailCoordinator.Params(rateEntity: predicateEntity))

        let exp = expectation(description: "Wait for ExchangeRate Currency")
        sut.output.currencyTextPublished
            .sink(receiveValue: { label in
                XCTAssertEqual(label, predicateEntity.currencyText)
                exp.fulfill()
            })
            .store(in: &cancellable)
        await fulfillment(of: [exp])
    }

    func test_output_rateLabel() async {
        let predicateEntity = ExchangeRateEntity.RateEntity.mockValue
        var (sut, cancellable) = makeSUT(param: ExchangeRateDetailCoordinator.Params(rateEntity: predicateEntity))

        let exp = expectation(description: "Wait for ExchangeRate Rate")
        sut.output.rateTextPublished
            .sink(receiveValue: { label in
                XCTAssertEqual(label, predicateEntity.rateText)
                exp.fulfill()
            })
            .store(in: &cancellable)
        await fulfillment(of: [exp])
    }

    func test_input_viewWillDisappear() {
        let predicateEntity = ExchangeRateEntity.RateEntity.mockValue
        let (sut, _) = makeSUT(param: ExchangeRateDetailCoordinator.Params(rateEntity: predicateEntity))

        let spy = SpyExchangeRateDetailViewModelDelegate()
        sut.delegate = spy
        sut.input.viewWillDisappear()

        XCTAssertEqual(spy.dismissCalledCount, 1)
    }
}

private class SpyExchangeRateDetailViewModelDelegate: ExchangeRateDetailViewModelDelegate {
    private(set) var dismissCalledCount = 0
    func dismiss() {
        dismissCalledCount += 1
    }
}

private extension ExchangeRateDetailViewModelTests {
    func makeSUT(param: ExchangeRateDetailCoordinator.Params, file: StaticString = #filePath, line: UInt = #line) -> (vm: ExchangeRateDetailViewModel, cancellable: Set<AnyCancellable>) {
        let vm = ExchangeRateDetailViewModel(param: param)
        trackForMemoryLeaks(vm)
        return (vm, Set<AnyCancellable>())
    }
}
