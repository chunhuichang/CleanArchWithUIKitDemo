//
//  ExchangeRateDTO+Mapping.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/19.
//

import Foundation

public struct ExchangeRateDTO {
    public let provider: String
    public let warningUpgradeToV6: String
    public let terms: String
    public let base: String
    public let date: String
    public let timeLastUpdated: Int
    public let rates: [String: Double]
}

extension ExchangeRateDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case provider
        case warningUpgradeToV6 = "WARNING_UPGRADE_TO_V6"
        case terms
        case base
        case date
        case timeLastUpdated = "time_last_updated"
        case rates
    }
}

public extension ExchangeRateDTO {
    func toDomain() throws -> ExchangeRateEntity {
        guard let baseCurrency = Currency(rawValue: base), let ratesDictionary = try? convertRates(rates) else {
            throw CommonError.convertToEntityError
        }

        return ExchangeRateEntity(base: baseCurrency, date: date, timeLastUpdated: timeLastUpdated, rates: ratesDictionary)
    }
}

private extension ExchangeRateDTO {
    func convertRates(_ rates: [String: Double]) throws -> [(Currency, Double)] {
        var ratesList: [(Currency, Double)] = []
        for (key, value) in rates {
            if let currency = Currency(rawValue: key) {
                ratesList.append((currency, value))
            } else {
                throw CommonError.convertToEntityError
            }
        }
        return ratesList
    }
}
