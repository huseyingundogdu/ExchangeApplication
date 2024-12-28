//
//  AccountListViewModel.swift
//  ExchangeApplication
//
//  Created by Huseyin on 20/12/2024.
//

import Foundation

class AccountListViewModel: ObservableObject {
    private var service = LocalService()
    
    @Published var accounts: [Account] = []
    @Published var exchanges: [Exchange] = []
    
    func fetchAccounts() async {
        do {
            accounts = try await service.fetchAccounts(user_id: "1")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchExchanges(by accountID: String) async { //byID
        exchanges = []
        do {
            exchanges = try await service.fetchExchanges(by: accountID)
//            print(exchanges)
        } catch {
            print(error.localizedDescription)
        }
    }
}
