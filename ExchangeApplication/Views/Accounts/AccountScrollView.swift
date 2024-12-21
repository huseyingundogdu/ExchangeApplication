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
        VStack(alignment: .leading) {
            Text("Total Balance")
                .font(.title2)
                .fontWeight(.bold)
            Text("\(totalBalance.formatted()) PLN")
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(vm.accounts, id: \.id) { account in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(account.currency)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .background(.red)
                            
                            Text(account.currencySymbol)
                            
                            Text(account.id)
                            
                            Text("\(account.balance.formatted())")
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(.top)
                        }
                        .frame(width: 250, height: 150, alignment: .topLeading)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.thinMaterial)
                        }
                    }
                    
                    // MARK: - Create New Account Card Button
                    NavigationLink {
                        CreateNewAccountView()
                    } label: {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Create New Account")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .background(.red)
                            Spacer()
                            
                            Image(systemName: "plus")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .frame(width: 250, height: 150, alignment: .topLeading)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.thinMaterial)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
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
    AccountScrollView()
}
