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
    func test_dataTrigger_successExchangeRateListGetEntity() async {
        let predicateEntity = ExchangeRateEntity.RateEntity.mockValue
        var (sut, cancellable) = makeSUT(param: ExchangeRateDetailCoordinator.Params(rateEntity: predicateEntity))

        let exp = expectation(description: "Wait for ExchangeRateList")
        sut.$rateEntity
            .sink(receiveValue: { entity in
                XCTAssertEqual(entity.currencyText, predicateEntity.currencyText)
                exp.fulfill()
            })
            .store(in: &cancellable)
        await fulfillment(of: [exp])
    }
}

private extension ExchangeRateDetailViewModelTests {
    func makeSUT(param: ExchangeRateDetailCoordinator.Params, file: StaticString = #filePath, line: UInt = #line) -> (vm: ExchangeRateDetailViewModel, cancellable: Set<AnyCancellable>) {
        let vm = ExchangeRateDetailViewModel(param: param)
        trackForMemoryLeaks(vm)
        return (vm, Set<AnyCancellable>())
    }
}

