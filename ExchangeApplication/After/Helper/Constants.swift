//
//  Constants.swift
//  ExchangeApplication
//
//  Created by Huseyin on 28/11/2024.
//

import Foundation

struct Constants {
    struct MockPaths {
        static let allCurrencies = "allCurrencies"
        static let userAccounts = "userAccounts"
        static let allExchanges = "PLNexchanges" // ALL
        static let EURExchanges = "EURexchanges" // EUR
        static let USDExchanges = "USDexchanges" // USD
        static let GBPExchanges = "GBPexchanges" // GBP
    }
    
    struct MockData {
        static let rates: Rates = [
            RateX(no: "221/C/NBP/2024", effectiveDate: "2024-11-14", bid: 4.0629, ask: 4.1449, mid: 0),
            RateX(no: "222/C/NBP/2024", effectiveDate: "2024-11-15", bid: 4.0629, ask: 4.1449, mid: 0),
            RateX(no: "223/C/NBP/2024", effectiveDate: "2024-11-16", bid: 4.0624, ask: 4.1444, mid: 0),
            RateX(no: "224/C/NBP/2024", effectiveDate: "2024-11-17", bid: 4.0455, ask: 4.1273, mid: 0),
            RateX(no: "225/C/NBP/2024", effectiveDate: "2024-11-18", bid: 4.0571, ask: 4.1391, mid: 0),
            RateX(no: "226/C/NBP/2024", effectiveDate: "2024-11-19", bid: 4.0845, ask: 4.1671, mid: 0),
            RateX(no: "227/C/NBP/2024", effectiveDate: "2024-11-20", bid: 4.0845, ask: 4.1671, mid: 0),
        ]
    }
    
    struct Endpoints {
        static let baseURL = "http://localhost:8080/v1"
        
        // MARK: - Auth
        static let login = baseURL + "/auth/login" // - POST
        static let register = baseURL + "/auth/register" // - POST
        
        // MARK: - Currency
        static let getAllCurrencies = baseURL + "/currency/table" // - GET, JWT
        static let getCurrencyByID = baseURL + "/currency/id" // - /{id}, GET, JWT
        static let getArchivedRatesByID = baseURL + "/currency/table/period" // - /{id}, GET, JWT
        
        // MARK: - Account
        static let getAllAccounts = baseURL + "/account/user" // - GET, JWT
    }
}
