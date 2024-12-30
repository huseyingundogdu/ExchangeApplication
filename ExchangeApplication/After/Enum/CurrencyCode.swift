//
//  CurrencyCode.swift
//  ExchangeApplication
//
//  Created by Huseyin on 28/12/2024.
//

import Foundation

enum CurrencyCode: String, CaseIterable, Identifiable {
    case USD, CHF, EUR, GBP, JPY, CZK, NOK
    var id: Self { self }
}
