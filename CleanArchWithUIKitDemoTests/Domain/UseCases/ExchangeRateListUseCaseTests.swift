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
        let predicateEntity = ExchangeRateEntity.mockValue
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
        MainExchangeRateListUseCase(repository: MockExchangeRateListRepository(result: result))
    }
}
