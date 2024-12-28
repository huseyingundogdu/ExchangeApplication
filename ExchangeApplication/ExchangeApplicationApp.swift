//
//  ExchangeApplicationApp.swift
//  ExchangeApplication
//
//  Created by Huseyin on 14/11/2024.
//

import SwiftUI

@main
struct ExchangeApplicationApp: App {
//    @StateObject private var navigationState = NavigationState()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .navigationTitle("Hello")
            }
        }
    }
}
