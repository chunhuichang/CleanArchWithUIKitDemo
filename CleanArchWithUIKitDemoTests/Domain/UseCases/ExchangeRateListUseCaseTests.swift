//
//  ExchangeRateUseCaseTests.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/8/20.
//

import CleanArchWithUIKitDemo
import Foundation
import Testing

@Suite
struct ExchangeRateListUseCaseTests {
    @Test
    func exchangeRate_deliversError() async {
        let predicateError = anyNSError()

        let sut = makeSUT(result: .failure(predicateError))

        let result = await sut.exchangeRateList(with: .USD)

        switch result {
        case let .failure(receivedError as NSError):
            #expect(receivedError.domain == predicateError.domain)
            #expect(receivedError.code == predicateError.code)
        default:
            Issue.record("Expected failure, got \(result) instead")
        }
    }

    @Test
    func exchangeRate_deliversEntityOnSuccess() async {
        let baseCurrency = Currency.USD
        let predicateEntity = ExchangeRateEntity(base: baseCurrency, date: "2024-8-20", timeLastUpdated: Int(Date().timeIntervalSinceNow), rates: [(.USD, 1), (.TWD, 32.09), (.JPY, 148.04), (.EUR, 0.908)])

        let sut = makeSUT(result: .success(predicateEntity))

        let result = await sut.exchangeRateList(with: baseCurrency)

        switch result {
        case let .success(entity):
            #expect(entity.base == predicateEntity.base)
            #expect(entity.date == predicateEntity.date)
            #expect(entity.timeLastUpdated == predicateEntity.timeLastUpdated)
            #expect(entity.rates.count == predicateEntity.rates.count)
            #expect(entity.getRate(with: baseCurrency) == predicateEntity.getRate(with: baseCurrency))
        default:
            Issue.record("Expected success, got \(result) instead")
        }
    }
}

// MARK: - Helpers

private extension ExchangeRateListUseCaseTests {
    func makeSUT(result: Result<ExchangeRateEntity, Error>) -> ExchangeRateListUseCase {
        MainExchangeRateListUseCase(repository: MockRepository(result: result))
    }
}

private struct MockRepository: ExchangeRateListRepository {
    private let result: Result<ExchangeRateEntity, Error>

    init(result: Result<ExchangeRateEntity, Error>) {
        self.result = result
    }

    func exchangeRateList(with base: CleanArchWithUIKitDemo.Currency) async -> Result<ExchangeRateEntity, Error> {
        result
    }
}
