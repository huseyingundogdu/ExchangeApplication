//
//  RateModel.swift
//  ExchangeApplication
//
//  Created by Huseyin on 29/12/2024.
//

import Foundation

@MainActor
class RateModel: ObservableObject {
    
    private var rateHTTPClient: RateHTTPClient
    
    init(client: RateHTTPClient) {
        self.rateHTTPClient = client
    }
    
    @Published var rates: Rates = []
    @Published var code: CurrencyCode = .USD
    
    
    func get30RateData(from: CurrencyCode) async throws -> Rates {
        try await rateHTTPClient.fetchLast30RateData(from: code)
    }
}
