//
//  ExchangeRateEntity.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/19.
//

import Foundation

public struct ExchangeRateEntity {
    public struct RateEntity {
        public let currency: Currency
        public let rate: Double

        public init(currency: Currency, rate: Double) {
            self.currency = currency
            self.rate = rate
        }
    }

    public init(base: Currency, date: String, timeLastUpdated: Int, rates: [RateEntity]) {
        self.base = base
        self.date = date
        self.timeLastUpdated = timeLastUpdated
        self.rates = rates
    }

    public let base: Currency
    public let date: String
    public let timeLastUpdated: Int
    public let rates: [RateEntity]
}

public extension ExchangeRateEntity {
    func getRate(with currency: Currency) -> Double? {
        rates.filter { $0.currency == currency }.first?.rate
    }
}

extension ExchangeRateEntity: MockEntity {
    public typealias T = Self
    public static var mockValue: ExchangeRateEntity {
        ExchangeRateEntity(base: .USD, date: "2024-8-20", timeLastUpdated: Int(Date().timeIntervalSinceNow), rates: [ExchangeRateEntity.RateEntity(currency: .USD, rate: 1), ExchangeRateEntity.RateEntity(currency: .TWD, rate: 32.09), ExchangeRateEntity.RateEntity(currency: .JPY, rate: 148.04), ExchangeRateEntity.RateEntity(currency: .EUR, rate: 0.908)])
    }
}

public enum CommonCurrency: String, CaseIterable {
    case USD, TWD, EUR, JPY, AUD
}

public enum Currency: String, CaseIterable {
    case USD, AED, AFN, ALL, AMD, ANG, AOA, ARS, AUD, AWG, AZN, BAM, BBD, BDT, BGN, BHD, BIF, BMD, BND, BOB, BRL, BSD, BTN, BWP, BYN, BZD, CAD, CDF, CHF, CLP, CNY, COP, CRC, CUP, CVE, CZK, DJF, DKK, DOP, DZD, EGP, ERN, ETB, EUR, FJD, FKP, FOK, GBP, GEL, GGP, GHS, GIP, GMD, GNF, GTQ, GYD, HKD, HNL, HRK, HTG, HUF, IDR, ILS, IMP, INR, IQD, IRR, ISK, JEP, JMD, JOD, JPY, KES, KGS, KHR, KID, KMF, KRW, KWD, KYD, KZT, LAK, LBP, LKR, LRD, LSL, LYD, MAD, MDL, MGA, MKD, MMK, MNT, MOP, MRU, MUR, MVR, MWK, MXN, MYR, MZN, NAD, NGN, NIO, NOK, NPR, NZD, OMR, PAB, PEN, PGK, PHP, PKR, PLN, PYG, QAR, RON, RSD, RUB, RWF, SAR, SBD, SCR, SDG, SEK, SGD, SHP, SLE, SLL, SOS, SRD, SSP, STN, SYP, SZL, THB, TJS, TMT, TND, TOP, TRY, TTD, TVD, TWD, TZS, UAH, UGX, UYU, UZS, VES, VND, VUV, WST, XAF, XCD, XDR, XOF, XPF, YER, ZAR, ZMW, ZWL
}
