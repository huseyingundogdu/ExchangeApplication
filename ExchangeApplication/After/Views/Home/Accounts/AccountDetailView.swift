//
//  AccountDetailView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 21/12/2024.
//

import SwiftUI

struct AccountDetailView: View {
    @EnvironmentObject private var accountModel: AccountModel

    var account: Account
    
    var body: some View {
        ZStack {
            Color.contentPrimary.ignoresSafeArea()
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
                
                NavigationLink(destination: SellView(code: CurrencyCode(rawValue: account.currencySymbol) ?? .USD)) {
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Delete Account") {
                        Task {
                            await accountModel.deleteAccount(accountID: account.id)
                        }
                    }
                    .foregroundStyle(.red)
                }
            }
        }
        .onAppear {
            Task {
                await accountModel.getExchanges(accountID: account.id)
            }
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
