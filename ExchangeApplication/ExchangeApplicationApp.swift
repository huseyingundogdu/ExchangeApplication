//
//  ExchangeApplicationApp.swift
//  ExchangeApplication
//
//  Created by Huseyin on 14/11/2024.
//

import SwiftUI

@main
struct ExchangeApplicationApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(RateModel(client: RateHTTPClient()))
                .environmentObject(AccountModel())
                .environmentObject(UserModel())
        }
    }
}
