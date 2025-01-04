//
//  AccountModel.swift
//  ExchangeApplication
//
//  Created by Huseyin on 29/12/2024.
//

import Foundation

@MainActor
class AccountModel: ObservableObject {
    
    private let service = LocalService()
    private let client = LocalHTTPClient()

    @Published var accounts: [Account] = []
    @Published var exchanges: [Exchange] = []
    
    func getAccounts() async {
        do {
            accounts = try await service.fetchAccounts(user_id: "1")
        } catch {
            print("error: account model get accounts")
        }
    }
    
    func getExchanges(by id: String) async {
        do {
            exchanges = try await client.fetchExchanges(by: id)
        } catch {
            print("error get exchanges account model")
        }
    }
}
