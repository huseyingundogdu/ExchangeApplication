//
//  AccountModel.swift
//  ExchangeApplication
//
//  Created by Huseyin on 29/12/2024.
//

import Foundation

struct AccountRequest: Codable {
    let currencyCode: String
}

@MainActor
class AccountModel: ObservableObject {
    
    private let webservice = Webservice()

    @Published var accounts: [Account] = []
    @Published var exchanges: [Exchange] = [] // related to History
    @Published var account: Account?
    
    func getAccounts() async {
        do {
            let response = try await webservice.request(
                endpoint: "/account/user",
                method: "GET",
                responseType: [Account].self
            )
//            print(response)
            DispatchQueue.main.async {
                self.accounts = response
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getAccount(id: String) async {
        do {
            let response = try await webservice.request(
                endpoint: "/account/\(id)",
                method: "GET",
                responseType: Account.self
            )
//            print(response)
            DispatchQueue.main.async {
                self.account = response
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getPLNAccountID() async -> String? {
        do {
            let response = try await webservice.request(
                endpoint: "/account/user",
                method: "GET",
                responseType: [Account].self
            )
            let plnAccount = accounts.filter { $0.currencySymbol == "AUD" }
            return plnAccount[0].id
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    // Ayir Bunu
    func getExchanges(accountID: String) async {
        do {
            let response = try await webservice.request(
                endpoint: "/exchange/account/\(accountID)",
                method: "GET",
                responseType: [Exchange].self
            )
            
            DispatchQueue.main.async {
                self.exchanges = response
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createAccount(code: CurrencyCode) async {
        let accountRequest = AccountRequest(currencyCode: code.rawValue)
        
        guard let body = try? JSONEncoder().encode(accountRequest) else {
            print("create account: encode error")
            return
        }
        
        do {
            let response = try await webservice.request(
                endpoint: "/account",
                method: "POST",
                body: body,
                responseType: Account.self
            )
            
            print("Account Created: \(response)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAccount(accountID: String) async {
        do {
            let response = try await webservice.request(
                endpoint: "/account/\(accountID)",
                method: "DELETE",
                responseType: String.self
            )
                        
            print("Account Deleted: \(response)")
        } catch {
            print(error.localizedDescription)
        }
    }
}
