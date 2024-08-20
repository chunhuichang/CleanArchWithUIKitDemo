//
//  ExchangeRateEntity.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/8/19.
//

import Foundation

public struct ExchangeRateEntity {
    public init(base: Currency, date: String, timeLastUpdated: Int, rates: [Currency: Double]) {
        self.base = base
        self.date = date
        self.timeLastUpdated = timeLastUpdated
        self.rates = rates
    }

    public let base: Currency
    public let date: String
    public let timeLastUpdated: Int
    public let rates: [Currency: Double]
}

public enum CommonCurrency: String, CaseIterable {
    case USD, TWD, EUR, JPY, AUD
}

public enum Currency: String, CaseIterable {
    case USD, AED, AFN, ALL, AMD, ANG, AOA, ARS, AUD, AWG, AZN, BAM, BBD, BDT, BGN, BHD, BIF, BMD, BND, BOB, BRL, BSD, BTN, BWP, BYN, BZD, CAD, CDF, CHF, CLP, CNY, COP, CRC, CUP, CVE, CZK, DJF, DKK, DOP, DZD, EGP, ERN, ETB, EUR, FJD, FKP, FOK, GBP, GEL, GGP, GHS, GIP, GMD, GNF, GTQ, GYD, HKD, HNL, HRK, HTG, HUF, IDR, ILS, IMP, INR, IQD, IRR, ISK, JEP, JMD, JOD, JPY, KES, KGS, KHR, KID, KMF, KRW, KWD, KYD, KZT, LAK, LBP, LKR, LRD, LSL, LYD, MAD, MDL, MGA, MKD, MMK, MNT, MOP, MRU, MUR, MVR, MWK, MXN, MYR, MZN, NAD, NGN, NIO, NOK, NPR, NZD, OMR, PAB, PEN, PGK, PHP, PKR, PLN, PYG, QAR, RON, RSD, RUB, RWF, SAR, SBD, SCR, SDG, SEK, SGD, SHP, SLE, SLL, SOS, SRD, SSP, STN, SYP, SZL, THB, TJS, TMT, TND, TOP, TRY, TTD, TVD, TWD, TZS, UAH, UGX, UYU, UZS, VES, VND, VUV, WST, XAF, XCD, XDR, XOF, XPF, YER, ZAR, ZMW, ZWL
}
