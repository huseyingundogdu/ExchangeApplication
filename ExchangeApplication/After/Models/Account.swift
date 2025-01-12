//
//  Account.swift
//  ExchangeApplication
//
//  Created by Huseyin on 20/12/2024.
//

import Foundation

struct Account: Codable {
    let id: String
    let userId: String
    let currency: String
    let currencySymbol: String
    let balance: Double
    let createdAt: String
}
