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
            
            DispatchQueue.main.async {
                if let response = response {
                    self.accounts = response
                }
            }
        } catch {
            print(error.localizedDescription + "getAccounts")
        }
    }
    
    
    func getAccount(id: String) async {
        do {
            let response = try await webservice.request(
                endpoint: "/account/\(id)",
                method: "GET",
                responseType: Account.self
            )

            DispatchQueue.main.async {
                self.account = response
            }
        } catch {
            print(error.localizedDescription + "getAccount(id:)")
        }
    }
    
    func fetchAccount(id: String) async -> Account? {
        do {
            let response = try await webservice.request(
                endpoint: "/account/\(id)",
                method: "GET",
                responseType: Account.self
            )

            return response
        } catch {
            print(error.localizedDescription + "getAccount(id:)")
            return nil
        }
    }
    
    func getPLNAccountID() async -> String? {
        do {
            let response = try await webservice.request(
                endpoint: "/account/user",
                method: "GET",
                responseType: [Account].self
            )
            let plnAccount = accounts.filter { $0.currencySymbol == "PLN" }
            return plnAccount[0].id
            
        } catch {
            print(error.localizedDescription + "getPLNAccountID")
            return nil
        }
    }
    
    func depositPLNAccount(accountID: String) async {
        do {
            let response = try await webservice.request(
                endpoint: "/account/\(accountID)",
                method: "PATCH",
                responseType: Account.self
            )
            
            //Message can set
            
            await getAccounts()
            
        } catch {
            print(error.localizedDescription)
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
                if let response {
                    self.exchanges = response
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getAllExchanges() async {
        do {
            let response = try await webservice.request(
                endpoint: "/exchange",
                method: "GET",
                responseType: [Exchange].self
            )
            
            DispatchQueue.main.async {
                if let response {
                    self.exchanges = response
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createAccount(code: CurrencyCode) async {
        let accountRequest = AccountRequest(currencyCode: code.rawValue.lowercased())
        
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
    
    func createPLNAccount() async {
        do {
            _ = try await webservice.request(
                endpoint: "/account/pln",
                method: "POST",
                responseType: Account.self
            )
            
        } catch let error as WebServiceError {
            print(error.description)
        } catch {
            print("cratePLNAccount() error: \(error.localizedDescription)")
        }
    }
}
