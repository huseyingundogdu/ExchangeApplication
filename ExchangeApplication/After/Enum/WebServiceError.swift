//
//  NSError.swift
//  ExchangeApplication
//
//  Created by Huseyin on 29/12/2024.
//

import Foundation

enum WebServiceError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
