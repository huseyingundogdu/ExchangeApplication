//
//  ContentView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 14/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        if authModel.isAuthenticated {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house").symbolRenderingMode(.multicolor)
                    }
                
                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "list.bullet").symbolRenderingMode(.multicolor)
                    }
                    .environmentObject(ExchangeModel())
                
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape").symbolRenderingMode(.multicolor)
                    }
            }
        } else {
            Login()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthModel())
        .environmentObject(AccountModel())
        .environmentObject(CurrencyModel())
        .environmentObject(ExchangeModel())
}
