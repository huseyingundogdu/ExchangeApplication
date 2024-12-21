//
//  ExchangeOperation.swift
//  ExchangeApplication
//
//  Created by Huseyin on 21/12/2024.
//

import Foundation

struct Exchange: Codable {
    let id: String
    let pln_account_id: String
    let other_account_id: String
    let plnAmount: Double
    let plnCurrency: String
    let otherAmount: Double
    let otherCurrency: String
    let operation: String
    let currencyRate: Double
    let transactionFee: Double
    let exchangeDate: String
}
