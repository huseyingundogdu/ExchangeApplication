//
//  AccountDetailView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 21/12/2024.
//

import SwiftUI

struct AccountDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var accountModel: AccountModel
    @State private var deleteErrorIsPresented = false
    var account: Account
    @State private var isLoading = true
    
    var body: some View {
        
        ZStack {
            Color.contentPrimary.ignoresSafeArea()
            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .foregroundStyle(.interactiveSecondary)
                    .frame(maxHeight: .infinity)
            } else {
                if let account = accountModel.account {
                    ScrollView {
                        VStack {
                            
                            HStack {
                                Image(account.currencySymbol)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Text(account.currencySymbol + " Account")
                                
                            }
                            
                            Text("\(account.balance.formatted(.currency(code: ""))) \(account.currencySymbol)")
                                .font(.title)
                                .fontWeight(.heavy)
                            
                            HStack {
                                Image(systemName: "building.columns.fill")
                                
                                Text(account.id)
                                    .padding(.vertical , 8)
                            }
                            .padding(.horizontal, 8)
                            .fontWeight(.semibold)
                            .foregroundStyle(.interactiveSecondary)
                            .background {
                                Capsule()
                                    .fill(.contentSecondary)
                            }
                        }
                        if account.currencySymbol != "PLN" {
                            NavigationLink(destination: ExchangeView(accountID: account.id)) {
                                VStack {
                                    Image(systemName: "arrow.left.arrow.right.circle.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(.interactiveSecondary)
                                    
                                    Text("Exchange")
                                        .fontWeight(.heavy)
                                        .foregroundStyle(.interactiveSecondary)
                                }
                                .padding(.vertical, 20)
                            }
                        }
                        
                        VStack {
                            Text("Exchange History")
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ForEach(accountModel.exchanges) { exchange in
                                NavigationLink(destination: ExchangeDetailView(exchange: exchange)) {
                                    ExchangeRow(exchange: exchange)
                                }
                            }
                        }
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .toolbar {
                        if account.currencySymbol != "PLN" {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Delete Account") {
                                    if let aacount = accountModel.account {
                                        if account.balance == 0 {
                                            Task {
                                                await accountModel.deleteAccount(accountID: account.id)
                                                dismiss()
                                            }
                                        } else {
                                            deleteErrorIsPresented = true
                                        }
                                    }
                                }
                                .foregroundStyle(.red)
                            }
                        }
                    }
                    .alert("There is still money in the account. You can't delete it.", isPresented: $deleteErrorIsPresented) {
                        Button("OK") {
                            deleteErrorIsPresented = false
                        }
                    }
                }
            }
        }
        .task {
            await loadData()
        }
        .toolbar(.hidden, for: .tabBar)
        
    }
    
    private func loadData() async {
        isLoading = true
        
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        defer { isLoading = false } // Ensure isLoading is set to false after the task completes
        
        await accountModel.getAccount(id: account.id)
        
        if account.currencySymbol == "PLN" {
            await accountModel.getAllExchanges()
        } else {
            await accountModel.getExchanges(accountID: account.id)
        }
    }
}

#Preview {
    let previewAccount = Account(
        id: "uniqueID-2",
        userId: "1",
        currency: "American Dollar",
        currencySymbol: "USD",
        balance: 1234.00,
        createdAt: "2024-12-15T19:06:08.971Z"
    )
    
    
    return NavigationStack {
        AccountDetailView(account: previewAccount)
            .environmentObject(AccountModel())
            .environmentObject(CurrencyModel())
    }
}
