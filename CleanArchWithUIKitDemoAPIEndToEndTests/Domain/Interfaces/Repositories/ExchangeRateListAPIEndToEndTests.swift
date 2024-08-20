//
//  ExchangeRateListAPIEndToEndTests.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/8/19.
//

import CleanArchWithUIKitDemo
import Foundation
import Testing

@Suite
struct ExchangeRateListAPIEndToEndTests {
    @Test("MainExchangeRateListRepository exchangeRateList")
    func getResult_matchesExchangeRateListEntityData() async {
        let baseCurrency = Currency.USD
        let result = await getExchangeRateEntityResult(with: baseCurrency)
        switch result {
        case let .success(entity):
            #expect(entity.base == baseCurrency)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            #expect(entity.date == dateFormatter.string(from: Date()))
        case let .failure(error):
            Issue.record("Expected success result, got \(error) instead")
        }
    }
}

// MARK: - Helpers

private extension ExchangeRateListAPIEndToEndTests {
    func getExchangeRateEntityResult(with currency: Currency) async -> Result<ExchangeRateEntity, Error> {
        let loader = RemoteDataLoader(client: URLSessionHTTPClient())

        let repository = MainExchangeRateListRepository(loadDataLoader: loader)

        return await repository.exchangeRateList(with: currency)
    }
}
