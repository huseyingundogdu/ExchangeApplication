//
//  ExchangeApplicationApp.swift
//  ExchangeApplication
//
//  Created by Huseyin on 14/11/2024.
//

import SwiftUI

@main
struct ExchangeApplicationApp: App {
    @StateObject private var authModel = AuthModel()
    @StateObject private var accountModel = AccountModel()
    @StateObject private var currencyModel = CurrencyModel()
    @StateObject private var exchangeModel = ExchangeModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authModel)
                .environmentObject(accountModel)
                .environmentObject(currencyModel)
                .environmentObject(exchangeModel)
                
        }
    }
}
