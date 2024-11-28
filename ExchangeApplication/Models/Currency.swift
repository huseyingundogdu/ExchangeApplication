//
//  Currency.swift
//  ExchangeApplication
//
//  Created by Huseyin on 28/11/2024.
//

import Foundation

struct Currency: Codable {
    let code: String
    let name: String
    let buy: Double
    let sell: Double
    let date: String
}

