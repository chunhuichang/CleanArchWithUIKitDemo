//
//  ExchangeRateListCoordinatorTests.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/8/31.
//

import CleanArchWithUIKitDemo
import UIKit
import XCTest

class ExchangeRateListCoordinatorTests: XCTestCase {
    func testStart_ShouldPushInitialViewController() {
        let sut = makeSUT()

        sut.start()

        let mockNavigationController = sut.navigationController as? MockNavigationController
        XCTAssertEqual(mockNavigationController?.pushedViewControllers.count, 1, "Exactly one view controller should be pushed")
        XCTAssertTrue(mockNavigationController?.pushedViewControllers.first is ExchangeRateListViewController, "The first pushed view controller should be of type ExchangeRateListViewController")
    }

    func test_goToDetail() {
        let sut = makeSUT()

        sut.goToDetail(rate: ExchangeRateEntity.RateEntity.mockValue)
        XCTAssertEqual(sut.childCoordinators.count, 1, "Exactly one child coordinator should be haved")
        let detailCoordinator = sut.childCoordinators.first
        XCTAssertTrue(detailCoordinator is ExchangeRateDetailCoordinator, "The first child coordinator should be of type ExchangeRateDetailCoordinator")
        let mockNavigationController = detailCoordinator?.navigationController as? MockNavigationController
        XCTAssertTrue(mockNavigationController?.pushedViewControllers.first is ExchangeRateDetailViewController, "The first pushed view controller should be of type ExchangeRateDetailViewController")
    }
}

private extension ExchangeRateListCoordinatorTests {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> ExchangeRateListCoordinator {
        let diContainer = ExchangeRateListDIContainer(dependencies: ExchangeRateListDIContainer.Dependencies(loadDataLoader: DummyDataServiceLoader()))
        let coordinator = diContainer.makeExchangeRateListCoordinator(navigationController: MockNavigationController())
        trackForMemoryLeaks(diContainer)
        trackForMemoryLeaks(coordinator)
        return coordinator
    }
}
