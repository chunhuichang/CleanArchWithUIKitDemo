//
//  ExchangeRateListRepository.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/20.
//

import Foundation

public protocol ExchangeRateListRepository {
    func exchangeRateList(with base: Currency) async -> Result<ExchangeRateEntity, Error>
}
