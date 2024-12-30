//
//  Rate.swift
//  ExchangeApplication
//
//  Created by Huseyin on 28/12/2024.
//

import Foundation

struct LineChartDataX: Codable {
    let table: String
    let currency: String
    let code: String
    let rates: Rates
}

struct RateX: Codable, Identifiable {
    var id: String { no }
    let no: String
    let effectiveDate: String
    let bid: Double
    let ask: Double
}

typealias Rates = [RateX]


