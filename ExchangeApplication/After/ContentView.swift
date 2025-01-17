//
//  ContentView.swift
//  ExchangeApplication
//
//  Created by Hüseyin Gündoğdu on 12/01/2025.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .contentPrimary
        UITabBar.appearance().tintColor = .interactiveSecondary
        UITabBar.appearance().unselectedItemTintColor = .interactivePrimary
    }
    
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        if authModel.isAuthenticated && !authModel.isLoading {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house").symbolRenderingMode(.multicolor)
                    }
                
                WealthView()
                    .tabItem {
                        Label("History", systemImage: "list.bullet").symbolRenderingMode(.multicolor)
                    }
                
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
