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
    func test_outputTrigger_displayEntityData() {
        let entity = ExchangeRateEntity.RateEntity.mockValue
        let (sut, _) = makeSUT(entity: entity)

        RunLoop.current.run(until: Date())
        XCTAssertEqual(sut.currencyLabel.text, entity.currencyText)
        XCTAssertEqual(sut.rateLabel.text, entity.rateText)
    }

    func test_viewWillDisappear_inputTrigger() {
        let entity = ExchangeRateEntity.RateEntity.mockValue
        let (sut, spyVM) = makeSUT(entity: entity)

        sut.viewWillDisappear(false)
        XCTAssertEqual(spyVM.viewWillDisappearCalledCount, 1)
    }
}

private extension ExchangeRateDetailViewControllerTests {
    func makeSUT(entity: ExchangeRateEntity.RateEntity, file: StaticString = #filePath, line: UInt = #line) -> (ExchangeRateDetailViewController, SpyExchangeRateDetailVMManager) {
        let vm = SpyExchangeRateDetailVMManager(entity)
        let vc = ExchangeRateDetailViewController(viewModel: vm)
        trackForMemoryLeaks(vm)
        trackForMemoryLeaks(vc)
        vc.triggerLifecycleIfNeeded()
        return (vc, vm)
    }
}

private class SpyExchangeRateDetailVMManager: ExchangeRateDetailVMManager, ExchangeRateDetailVMOutput, ExchangeRateDetailVMInput {
    private(set) var viewWillDisappearCalledCount = 0
    var delegate: ExchangeRateDetailViewModelDelegate?

    @Published private var currencyText: String
    @Published private var rateText: String

    init(_ entity: ExchangeRateEntity.RateEntity) {
        currencyText = entity.currencyText
        rateText = entity.rateText
    }

    var output: ExchangeRateDetailVMOutput { self }

    var currencyTextPublished: Published<String>.Publisher {
        $currencyText
    }

    var rateTextPublished: Published<String>.Publisher {
        $rateText
    }

    var input: ExchangeRateDetailVMInput { self }

    func viewWillDisappear() {
        viewWillDisappearCalledCount += 1
    }
}
