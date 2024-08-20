//
//  ExchangeRateListUseCase.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/20.
//

import Foundation

public protocol ExchangeRateListUseCase {
    func exchangeRateList(with base: Currency) async -> Result<ExchangeRateEntity, Error>
}

public struct MainExchangeRateListUseCase {
    private let repository: ExchangeRateListRepository

    public init(repository: ExchangeRateListRepository) {
        self.repository = repository
    }
}

extension MainExchangeRateListUseCase: ExchangeRateListUseCase {
    public func exchangeRateList(with base: Currency) async -> Result<ExchangeRateEntity, Error> {
        await repository.exchangeRateList(with: base)
    }
}
