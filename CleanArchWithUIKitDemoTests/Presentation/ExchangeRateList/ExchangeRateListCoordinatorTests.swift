//
//  ExchangeRateListCoordinatorTests.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/8/31.
//

import CleanArchWithUIKitDemo
import SwiftUI
import UIKit
import XCTest

class ExchangeRateListCoordinatorTests: XCTestCase {
    func testStart_ShouldPushInitialViewController() {
        for view in PresentationView.allCases {
            pushInitialView(view: view)
        }
    }

    private func pushInitialView(view: PresentationView) {
        let sut = makeSUT(view: view)

        sut.start()

        let mockNavigationController = sut.navigationController as? MockNavigationController
        guard let firstViewController = mockNavigationController?.pushedViewControllers.first else {
            XCTFail("Exactly one view controller should be pushed")
            return
        }

        switch view {
        case .UIKit:
            XCTAssertTrue(firstViewController is ExchangeRateListViewController, "The first pushed view controller should be of type ExchangeRateListViewController")
        case .SwiftUI:
            XCTAssertTrue(firstViewController is UIHostingController<ExchangeRateListView>, "The first pushed view controller should be of type UIHostingController<ExchangeRateListView>")
        }
    }

    func test_goToDetail() {
        for view in PresentationView.allCases {
            goToDetail(view: view)
        }
    }

    private func goToDetail(view: PresentationView) {
        let sut = makeSUT(view: view)

        sut.goToDetail(rate: ExchangeRateEntity.RateEntity.mockValue)

        guard let detailCoordinator = sut.childCoordinators.first as? ExchangeRateDetailCoordinator else {
            XCTFail("The first child coordinator should be of type ExchangeRateDetailCoordinator")
            return
        }

        guard let firstViewController = (detailCoordinator.navigationController as? MockNavigationController)?.pushedViewControllers.first else {
            XCTFail("Exactly one view controller should be pushed")
            return
        }
        switch view {
        case .UIKit:
            XCTAssertTrue(firstViewController is ExchangeRateDetailViewController, "The first pushed view controller should be of type ExchangeRateListViewController")
        case .SwiftUI:
            XCTAssertTrue(firstViewController is UIHostingController<ExchangeRateDetailView>, "The first pushed view controller should be of type UIHostingController<ExchangeRateListView>")
        }
    }

    func test_dismiss_triggerRemoveCoordinator() {
        let sut = makeSUT(view: .UIKit)

        sut.goToDetail(rate: ExchangeRateEntity.RateEntity.mockValue)
        XCTAssertEqual(sut.childCoordinators.count, 1, "Exactly one child coordinator should be haved")

        guard let detailCoordinator = sut.childCoordinators.first as? ExchangeRateDetailCoordinator else {
            XCTFail("Coordinator should be of type ExchangeRateDetailCoordinator")
            return
        }
        detailCoordinator.dismiss()

        XCTAssertEqual(sut.childCoordinators.count, 0)
    }
}

private extension ExchangeRateListCoordinatorTests {
    func makeSUT(view: PresentationView, file: StaticString = #filePath, line: UInt = #line) -> ExchangeRateListCoordinator {
        let diContainer = ExchangeRateListDIContainer(dependencies: ExchangeRateListDIContainer.Dependencies(loadDataLoader: DummyDataServiceLoader()), view: view)
        let coordinator = diContainer.makeExchangeRateListCoordinator(navigationController: MockNavigationController())
        trackForMemoryLeaks(diContainer, file: file, line: line)
        trackForMemoryLeaks(coordinator, file: file, line: line)
        return coordinator
    }
}
