//
//  MockExchangeRateListRepository.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/31.
//

import Foundation

public struct MockExchangeRateListRepository: ExchangeRateListRepository {
    private let result: Result<ExchangeRateEntity, Error>
    
    public init(result: Result<ExchangeRateEntity, Error> = .success(ExchangeRateEntity.mockValue)) {
        self.result = result
    }

    public func exchangeRateList(with base: Currency) async -> Result<ExchangeRateEntity, Error> {
        result
    }
}
