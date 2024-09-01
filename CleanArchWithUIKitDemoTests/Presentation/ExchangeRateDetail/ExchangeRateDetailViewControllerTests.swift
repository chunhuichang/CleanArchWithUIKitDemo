//
//  ExchangeRateDetailViewControllerTests.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/9/1.
//

import CleanArchWithUIKitDemo
import Combine
import XCTest

class ExchangeRateDetailViewControllerTests: XCTestCase {
    func test_hasData_displayTableView() {
        let entity = ExchangeRateEntity.RateEntity.mockValue
        let sut = makeSUT(param: ExchangeRateDetailCoordinator.Params(rateEntity: entity))
        
        RunLoop.current.run(until: Date())
        XCTAssertEqual(sut.currencyLabel.text, entity.currencyText)
        XCTAssertEqual(sut.rateLabel.text, entity.rateText)
    }
}

private extension ExchangeRateDetailViewControllerTests {
    func makeSUT(param: ExchangeRateDetailCoordinator.Params, file: StaticString = #filePath, line: UInt = #line) -> ExchangeRateDetailViewController {
        let vm = ExchangeRateDetailViewModel(param: param)
        let vc = ExchangeRateDetailViewController(viewModel: vm)
        trackForMemoryLeaks(vm)
        trackForMemoryLeaks(vc)
        vc.triggerLifecycleIfNeeded()
        return vc
    }
}
