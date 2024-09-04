//
//  ExchangeRateDetailCoordinatorTests.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/8/31.
//

import CleanArchWithUIKitDemo
import UIKit
import XCTest

class ExchangeRateDetailCoordinatorTests: XCTestCase {
    func testStart_ShouldPushInitialViewController() {
        let sut = makeSUT()

        sut.start()

        let mockNavigationController = sut.navigationController as? MockNavigationController
        XCTAssertEqual(mockNavigationController?.pushedViewControllers.count, 1, "Exactly one view controller should be pushed")
        XCTAssertTrue(mockNavigationController?.pushedViewControllers.first is ExchangeRateDetailViewController, "The first pushed view controller should be of type ExchangeRateListViewController")
    }

    func test_trigger_dismiss() {
        let sut = makeSUT()
        let spy = SpyExchangeRateDetailCoordinatorDelegate()
        sut.delegate = spy
        sut.start()

        let detailVC = (sut.navigationController as? MockNavigationController)?.pushedViewControllers.first as? ExchangeRateDetailViewController
        detailVC?.viewModel.input.viewWillDisappear()

        XCTAssertEqual(spy.dismissCallCount, 1)
    }
}

private class SpyExchangeRateDetailCoordinatorDelegate: ExchangeRateDetailCoordinatorDelegate {
    private(set) var dismissCallCount = 0
    func dismiss(_: Coordinator) {
        dismissCallCount += 1
    }
}

private extension ExchangeRateDetailCoordinatorTests {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> ExchangeRateDetailCoordinator {
        let diContainer = ExchangeRateDetailDIContainer()
        let coordinator = diContainer.makeExchangeRateDetailCoordinator(navigationController: MockNavigationController(), param: ExchangeRateDetailCoordinator.Params(rateEntity: ExchangeRateEntity.RateEntity.mockValue))
        trackForMemoryLeaks(diContainer)
        trackForMemoryLeaks(coordinator)
        return coordinator
    }
}
