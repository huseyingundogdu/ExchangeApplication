//
//  ExchangeModel.swift
//  ExchangeApplication
//
//  Created by Huseyin on 30/12/2024.
//

import Foundation

@MainActor
class ExchangeModel: ObservableObject {

    let client: LocalHTTPClient
    
    init(client: LocalHTTPClient) {
        self.client = client
    }
    
    @Published var exchanges: [Exchange] = []
    
    func loadExchanges() async throws {
        exchanges = try await getAllExchanges()
    }
    
    func getAllExchanges() async throws -> [Exchange] {
        try await client.fetchAllExchanges()
    }
    
    func getExchanges(by id: String) async throws -> [Exchange] {
        try await client.fetchExchanges(by: id)
    }
}
