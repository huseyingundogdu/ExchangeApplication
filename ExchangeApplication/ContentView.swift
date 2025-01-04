//
//  ContentView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 14/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        // Configure tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground() // Ensures a consistent background appearance
        appearance.backgroundColor = UIColor.contentPrimary // Set the tab bar background color
        
        // Add a stroke (separator) at the top of the tab bar
        appearance.shadowColor = UIColor.interactiveSecondary // Set the stroke color
        // Optional: Use a shadowImage if you need more control over the appearance.
        // appearance.shadowImage = UIImage(named: "CustomStrokeImage")
        
        // Configure item appearance for normal and selected states
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor.interactivePrimary // Color for unselected items
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.interactivePrimary]
        itemAppearance.selected.iconColor = UIColor.interactiveSecondary // Color for selected items
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.interactiveSecondary]
        appearance.stackedLayoutAppearance = itemAppearance // Apply item appearance
        
        // Assign configured appearance to the UITabBar
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance
        
        // Set tintColor to align selected state (fallback for unsupported SF Symbols)
        UITabBar.appearance().tintColor = UIColor.interactiveSecondary
    }
    
    var body: some View {
        
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house").symbolRenderingMode(.multicolor)
                }
                .environmentObject(UserModel())
                .environmentObject(AccountModel())
                .environmentObject(RateModel(client: RateHTTPClient()))
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "list.bullet").symbolRenderingMode(.multicolor)
                }
                .environmentObject(ExchangeModel(client: LocalHTTPClient()))
                
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape").symbolRenderingMode(.multicolor)
                }
        }
        
        
        
    }
}

#Preview {
    ContentView()
}
