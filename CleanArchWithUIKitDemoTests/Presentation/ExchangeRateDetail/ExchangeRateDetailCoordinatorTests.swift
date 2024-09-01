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
