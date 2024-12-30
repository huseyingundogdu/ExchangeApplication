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

    @Published var accounts: [Account] = []
    
    
    func getAccounts() async {
        do {
            accounts = try await service.fetchAccounts(user_id: "1")
        } catch {
            print("error: account model get accounts")
        }
    }
}
