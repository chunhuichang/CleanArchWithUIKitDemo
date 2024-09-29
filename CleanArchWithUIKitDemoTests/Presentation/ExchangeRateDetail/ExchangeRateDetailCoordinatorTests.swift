//
//  ExchangeRateDetailCoordinatorTests.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/8/31.
//

import CleanArchWithUIKitDemo
import SwiftUI
import UIKit
import XCTest

class ExchangeRateDetailCoordinatorTests: XCTestCase {
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
            XCTAssertTrue(firstViewController is ExchangeRateDetailViewController, "The first pushed view controller should be of type ExchangeRateDetailViewController")
        case .SwiftUI:
            XCTAssertTrue(firstViewController is UIHostingController<ExchangeRateDetailView>, "The first pushed view controller should be of type UIHostingController<ExchangeRateDetailView>")
        }
    }

    func test_triggerViewController_dismiss() {
        for view in PresentationView.allCases {
            triggerViewDismiss(view: view)
        }
    }

    private func triggerViewDismiss(view: PresentationView) {
        let sut = makeSUT(view: view)
        let spy = SpyExchangeRateDetailCoordinatorDelegate()
        sut.delegate = spy
        sut.start()

        switch view {
        case .UIKit:
            let detailVC = (sut.navigationController as? MockNavigationController)?.pushedViewControllers.first as? ExchangeRateDetailViewController
            detailVC?.viewModel.input.viewWillDisappear()

        case .SwiftUI:
            let detailView = ((sut.navigationController as? MockNavigationController)?.pushedViewControllers.first as? UIHostingController<ExchangeRateDetailView>)?.rootView
            detailView?.viewModel.input.viewWillDisappear()
        }

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
    func makeSUT(view: PresentationView, file: StaticString = #filePath, line: UInt = #line) -> ExchangeRateDetailCoordinator {
        let diContainer = ExchangeRateDetailDIContainer()
        let coordinator = diContainer.makeExchangeRateDetailCoordinator(navigationController: MockNavigationController(), param: ExchangeRateDetailCoordinator.Params(rateEntity: ExchangeRateEntity.RateEntity.mockValue, view: view))
        trackForMemoryLeaks(diContainer, file: file, line: line)
        trackForMemoryLeaks(coordinator, file: file, line: line)
        return coordinator
    }
}
