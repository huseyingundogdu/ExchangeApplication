//
//  AccountListView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 28/11/2024.
//

import SwiftUI

struct TempAccount {
    let id: String
    let number: String
    let currency: String
    let balance: Float
}

struct AccountScrollView: View {
    
    @StateObject private var vm = AccountListViewModel()
    
    let totalBalance = 232123.45
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(vm.accounts, id: \.id) { account in
                    NavigationLink(destination: AccountDetailView(account: account)) { AccountCardView(account: account) }
                        .buttonStyle(.plain)
                }
                
                // MARK: - Create New Account Card Button
                NavigationLink {
                    CreateNewAccountView()
                } label: {
                    VStack(alignment: .leading, spacing: 5) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .fontWeight(.light)
                        
                        Spacer()
                        
                        Text("Create New Account")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 220, height: 150, alignment: .topLeading)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .foregroundStyle(.interactiveSecondary)
                            
                    }
                    .foregroundStyle(.interactiveSecondary)
                }
                .buttonStyle(.plain)
            }
        }
        .scrollIndicators(.hidden)
        .onAppear {
            Task {
                await vm.fetchAccounts()
            }
        }
    }
    
    private func maskString(_ input: String) -> String {
        guard input.count > 8 else { return input } // Ensure the string is long enough
        
        let start = input.prefix(4) // Get the first 4 characters
        let end = input.suffix(4)  // Get the last 4 characters
        let middle = String(repeating: "*", count: input.count - 8) // Replace the middle with *
        
        return start + middle + end
    }
}

#Preview {
    NavigationStack {
        AccountScrollView()
    }
}
