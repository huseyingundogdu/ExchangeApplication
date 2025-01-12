//
//  SettingsView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 29/12/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        ZStack {
            Color.contentPrimary.ignoresSafeArea()
            VStack {
                Button("Logout") {
                    authModel.logout()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
