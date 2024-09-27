//
//  ExchangeRateListViewControllerTests.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/8/23.
//

import CleanArchWithUIKitDemo
import Combine
import XCTest

class ExchangeRateListViewControllerTests: XCTestCase {
    func test_hasData_displayTableView() {
        let (sut, _) = makeSUTWithSuccessResult()

        let expectation = expectation(description: "Table view reload should complete")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error, "Test timed out")

            XCTAssertEqual(sut.tableView.numberOfSections, 1)
            XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 4)
        }
    }

    func test_hasData_cellConfig() {
        let (sut, entity) = makeSUTWithSuccessResult()
        let expectation = expectation(description: "Table view reload should complete")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error, "Test timed out")

            let firstRow = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))

            guard let contentConfig = firstRow?.contentConfiguration as? UIListContentConfiguration else {
                XCTFail("ContentConfiguration should be of type UIListContentConfiguration")
                return
            }
            XCTAssertEqual(contentConfig.text, entity.rates.first?.currencyText)
            XCTAssertEqual(contentConfig.secondaryText, entity.rates.first?.rateText)
        }
    }
}

private extension ExchangeRateListViewControllerTests {
    func makeSUT(result: Result<ExchangeRateEntity, Error>, file: StaticString = #filePath, line: UInt = #line) -> ExchangeRateListViewController {
        let usecase = MockExchangeRateListUseCase(result: result)
        let vm = ExchangeRateListViewModel(usecase)
        let vc = ExchangeRateListViewController(viewModel: vm)
        trackForMemoryLeaks(vm, file: file, line: line)
        trackForMemoryLeaks(vc, file: file, line: line)
        vc.triggerLifecycleIfNeeded()
        _ = makeNewWindow(view: vc.view)
        return vc
    }

    func makeSUTWithSuccessResult(file _: StaticString = #filePath, line _: UInt = #line) -> (viewController: ExchangeRateListViewController, entity: ExchangeRateEntity) {
        let predicateEntity = ExchangeRateEntity.mockValue
        return (makeSUT(result: .success(predicateEntity)), predicateEntity)
    }
}
