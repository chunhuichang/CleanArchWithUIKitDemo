//
//  ExchangeRateTests.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/8/19.
//

import CleanArchWithUIKitDemo
import Foundation
import Testing

@Suite
struct ExchangeRateTests {
    @Test
    func jsonStirng_successDecodeEntity() {
        let json = """
        {
            "provider": "https://www.exchangerate-api.com",
            "WARNING_UPGRADE_TO_V6": "https://www.exchangerate-api.com/docs/free",
            "terms": "https://www.exchangerate-api.com/terms",
            "base": "USD",
            "date": "2024-08-19",
            "time_last_updated": 1724025601,
            "rates": {
                "USD": 1,
                "AED": 3.67,
                "AFN": 71.02,
                "ALL": 90.55,
                "AMD": 388.11,
                "ANG": 1.79,
                "AOA": 896.22,
                "ARS": 944,
                "AUD": 1.5,
                "AWG": 1.79,
                "AZN": 1.7,
                "BAM": 1.77,
                "BBD": 2,
                "BDT": 117.54,
                "BGN": 1.78,
                "BHD": 0.376,
                "BIF": 2881.35,
                "BMD": 1,
                "BND": 1.32,
                "BOB": 6.93,
                "BRL": 5.47,
                "BSD": 1,
                "BTN": 83.92,
                "BWP": 13.4,
                "BYN": 3.26,
                "BZD": 2,
                "CAD": 1.37,
                "CDF": 2850.84,
                "CHF": 0.867,
                "CLP": 936.55,
                "CNY": 7.17,
                "COP": 4017.48,
                "CRC": 520.08,
                "CUP": 24,
                "CVE": 100.07,
                "CZK": 22.87,
                "DJF": 177.72,
                "DKK": 6.77,
                "DOP": 59.83,
                "DZD": 134.35,
                "EGP": 48.84,
                "ERN": 15,
                "ETB": 109.54,
                "EUR": 0.908,
                "FJD": 2.23,
                "FKP": 0.773,
                "FOK": 6.77,
                "GBP": 0.773,
                "GEL": 2.69,
                "GGP": 0.773,
                "GHS": 15.61,
                "GIP": 0.773,
                "GMD": 70.42,
                "GNF": 8704.91,
                "GTQ": 7.75,
                "GYD": 209.31,
                "HKD": 7.8,
                "HNL": 24.83,
                "HRK": 6.84,
                "HTG": 131.72,
                "HUF": 358.43,
                "IDR": 15688.06,
                "ILS": 3.68,
                "IMP": 0.773,
                "INR": 83.92,
                "IQD": 1310.7,
                "IRR": 42069.27,
                "ISK": 139.11,
                "JEP": 0.773,
                "JMD": 157.21,
                "JOD": 0.709,
                "JPY": 148.04,
                "KES": 128.98,
                "KGS": 85.73,
                "KHR": 4124.25,
                "KID": 1.5,
                "KMF": 446.48,
                "KRW": 1350,
                "KWD": 0.306,
                "KYD": 0.833,
                "KZT": 478.95,
                "LAK": 22023.72,
                "LBP": 89500,
                "LKR": 298.57,
                "LRD": 195.26,
                "LSL": 17.86,
                "LYD": 4.79,
                "MAD": 9.77,
                "MDL": 17.58,
                "MGA": 4577.47,
                "MKD": 55.94,
                "MMK": 2102.11,
                "MNT": 3378.95,
                "MOP": 8.03,
                "MRU": 39.8,
                "MUR": 46.31,
                "MVR": 15.42,
                "MWK": 1737.45,
                "MXN": 18.63,
                "MYR": 4.43,
                "MZN": 63.91,
                "NAD": 17.86,
                "NGN": 1589.5,
                "NIO": 36.85,
                "NOK": 10.69,
                "NPR": 134.27,
                "NZD": 1.65,
                "OMR": 0.384,
                "PAB": 1,
                "PEN": 3.74,
                "PGK": 3.89,
                "PHP": 57.08,
                "PKR": 278.49,
                "PLN": 3.87,
                "PYG": 7608.24,
                "QAR": 3.64,
                "RON": 4.53,
                "RSD": 106.44,
                "RUB": 89.38,
                "RWF": 1322.06,
                "SAR": 3.75,
                "SBD": 8.51,
                "SCR": 13.52,
                "SDG": 458.74,
                "SEK": 10.45,
                "SGD": 1.32,
                "SHP": 0.773,
                "SLE": 22.45,
                "SLL": 22451.42,
                "SOS": 571.89,
                "SRD": 28.89,
                "SSP": 2683.86,
                "STN": 22.23,
                "SYP": 12860.52,
                "SZL": 17.86,
                "THB": 34.86,
                "TJS": 10.61,
                "TMT": 3.5,
                "TND": 3.07,
                "TOP": 2.34,
                "TRY": 33.71,
                "TTD": 6.79,
                "TVD": 1.5,
                "TWD": 32.09,
                "TZS": 2702.28,
                "UAH": 41.23,
                "UGX": 3724.13,
                "UYU": 40.42,
                "UZS": 12707.57,
                "VES": 36.68,
                "VND": 25048.49,
                "VUV": 118.24,
                "WST": 2.73,
                "XAF": 595.31,
                "XCD": 2.7,
                "XDR": 0.748,
                "XOF": 595.31,
                "XPF": 108.3,
                "YER": 250.32,
                "ZAR": 17.86,
                "ZMW": 26.38,
                "ZWL": 13.79
            }
        }
        """
        
        guard let jsonData = json.data(using: .utf8) else {
            Issue.record("string converted JSON Error.")
            return
        }
        
        guard let dto: ExchangeRateDTO = try? JSONDecoder().decode(ExchangeRateDTO.self, from: jsonData) else {
            Issue.record("data decode DTO Error.")
            return
        }
        
        guard let entity = try? dto.toDomain() else {
            Issue.record("data convert DTO to Entity Error.")
            return
        }
        
        let baseCurrency = Currency.USD
        #expect(entity.base == baseCurrency)
        #expect(entity.date == "2024-08-19")
        #expect(entity.timeLastUpdated == 1724025601)
        #expect(entity.rates.count == 162)
        #expect(entity.getRate(with: baseCurrency) == 1)
    }
    
    @Test
    func jsonStirng_failureDecodeEntity() {
        let json = """
        {
            "provider": "https://www.exchangerate-api.com",
            "WARNING_UPGRADE_TO_V6": "https://www.exchangerate-api.com/docs/free",
            "terms": "https://www.exchangerate-api.com/terms",
            "date": "2024-08-19",
            "time_last_updated": 1724025601
        }
        """
        
        guard let jsonData = json.data(using: .utf8) else {
            Issue.record("string converted JSON Error.")
            return
        }
        
        guard let _: ExchangeRateDTO = try? JSONDecoder().decode(ExchangeRateDTO.self, from: jsonData) else {
            #expect(true)
            return
        }
        Issue.record("data decode DTO Error.")
    }
    
    @Test
    func jsonStirng_failureConvertEntityAtBase() {
        let json = """
        {
            "provider": "https://www.exchangerate-api.com",
            "WARNING_UPGRADE_TO_V6": "https://www.exchangerate-api.com/docs/free",
            "terms": "https://www.exchangerate-api.com/terms",
            "base": "USDA",
            "date": "2024-08-19",
            "time_last_updated": 1724025601,
            "rates": {
                "USD": 1,
                "AED": 3.67,
                "AFN": 71.02,
                "ALL": 90.55,
            }
        }
        """
        
        guard let jsonData = json.data(using: .utf8) else {
            Issue.record("string converted JSON Error.")
            return
        }
        
        guard let dto: ExchangeRateDTO = try? JSONDecoder().decode(ExchangeRateDTO.self, from: jsonData) else {
            Issue.record("data decode DTO Error.")
            return
        }
        
        do {
            _ = try dto.toDomain()
            Issue.record("data convert Entity Error.")
        } catch {
            if case CommonError.convertToEntityError = error {
                #expect(true)
            } else {
                Issue.record("data convert Entity Error.")
            }
        }
    }
    
    @Test
    func jsonStirng_failureConvertEntityAtRates() {
        let json = """
        {
            "provider": "https://www.exchangerate-api.com",
            "WARNING_UPGRADE_TO_V6": "https://www.exchangerate-api.com/docs/free",
            "terms": "https://www.exchangerate-api.com/terms",
            "base": "USD",
            "date": "2024-08-19",
            "time_last_updated": 1724025601,
            "rates": {
                "USDA": 1,
                "AED": 3.67,
                "AFN": 71.02,
                "ALL": 90.55,
            }
        }
        """
        
        guard let jsonData = json.data(using: .utf8) else {
            Issue.record("string converted JSON Error.")
            return
        }
        
        guard let dto: ExchangeRateDTO = try? JSONDecoder().decode(ExchangeRateDTO.self, from: jsonData) else {
            Issue.record("data decode DTO Error.")
            return
        }
        
        do {
            _ = try dto.toDomain()
            Issue.record("data convert Entity Error.")
        } catch {
            if case CommonError.convertToEntityError = error {
                #expect(true)
            } else {
                Issue.record("data convert Entity Error.")
            }
        }
    }
}
