//
//  ExchangeModel.swift
//  ExchangeApplication
//
//  Created by Huseyin on 30/12/2024.
//

import Foundation

struct ExchangeRequest: Codable {
    let plnAccount_id: String
    let otherAccount_id: String
    let currency_code: String
    let amount: Double
}

@MainActor
class ExchangeModel: ObservableObject {

    
    @Published var exchanges: [Exchange] = []
    
    func loadExchanges() async throws {
        exchanges = try await getAllExchanges()
    }
    
    func getAllExchanges() async throws -> [Exchange] {
        return []
    }
    
    func getExchanges(accountID: String) async {

    }
    
    func postExchange(plnAccountID: String, otherAccountID: String, currencyCode: String, amount: Double) async {
        
        
        
    }
}
