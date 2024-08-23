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

        XCTAssertEqual(sut.tableView.numberOfSections, 1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 4)
    }

    func test_hasData_cellConfig() {
        let (sut, entity) = makeSUTWithSuccessResult()
        // Trigger the run loop to allow the table view to lay out its cells
        RunLoop.current.run(until: Date())
        let firstRow = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))

        XCTAssertEqual(firstRow?.textLabel?.text, entity.rates.first?.currency.rawValue)
    }
}

private extension ExchangeRateListViewControllerTests {
    func makeSUT(result: Result<ExchangeRateEntity, Error>, file: StaticString = #filePath, line: UInt = #line) -> ExchangeRateListViewController {
        let usecase = MockUseCase(result: result)
        let vm = ExchangeRateListViewModel(usecase)
        let vc = ExchangeRateListViewController(viewModel: vm)
        trackForMemoryLeaks(vm)
        trackForMemoryLeaks(vc)
        vc.triggerLifecycleIfNeeded()
        return vc
    }

    func makeSUTWithSuccessResult(file: StaticString = #filePath, line: UInt = #line) -> (viewController: ExchangeRateListViewController, entity: ExchangeRateEntity) {
        let predicateEntity = ExchangeRateEntity(base: .USD, date: "2024-8-20", timeLastUpdated: Int(Date().timeIntervalSinceNow), rates: [(.USD, 1), (.TWD, 32.09), (.JPY, 148.04), (.EUR, 0.908)])
        return (makeSUT(result: .success(predicateEntity)), predicateEntity)
    }
}

private struct MockUseCase: ExchangeRateListUseCase {
    private let result: Result<ExchangeRateEntity, Error>

    init(result: Result<ExchangeRateEntity, Error>) {
        self.result = result
    }

    func exchangeRateList(with base: Currency) async -> Result<ExchangeRateEntity, any Error> {
        result
    }
}
