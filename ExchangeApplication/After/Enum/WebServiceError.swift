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
    case notFound
    case serverError
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .invalidData:
            return "Failed to decode the response."
        case .notFound:
            return "The requested resource was not found (404)."
        case .serverError:
            return "A server error occurred (500+)."
        }
    }
}
