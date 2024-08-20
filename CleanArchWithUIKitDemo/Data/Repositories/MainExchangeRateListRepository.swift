//
//  MainExchangeRateListRepository.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/20.
//

import Foundation

public final class MainExchangeRateListRepository: ExchangeRateListRepository {
    private let loadDataLoader: DataServiceLoader

    public init(loadDataLoader: DataServiceLoader) {
        self.loadDataLoader = loadDataLoader
    }

    public func exchangeRateList(with base: Currency) async -> Result<ExchangeRateEntity, Error> {
        let result: DataLoaderResult<ExchangeRateDTO> = await loadDataLoader.load(config: ExchangeRateListApi(with: base))

        switch result {
        case let .success(dto):
            do {
                return try .success(dto.toDomain())
            } catch {
                return .failure(error)
            }
        case let .failure(error):
            return .failure(error)
        }
    }
}
