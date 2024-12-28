//
//  AccountDetailView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 21/12/2024.
//

import SwiftUI

struct AccountDetailView: View {
    
    @StateObject private var vm = AccountListViewModel()
    
    var account: Account
    //var exchanges: [Exchange] = vm.exchanges
    
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
                
                Button {
                    
                } label: {
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

                    
                    
                    ForEach(vm.exchanges, id: \.id) { exchange in
                        if exchange.operation == "buy" {
                            HStack {
                                Text(exchange.plnCurrency + " to " + exchange.otherCurrency)
                                    
                                Spacer()
                                
                                Text("+\(exchange.otherAmount.formatted(.currency(code: exchange.otherCurrency)))")
                                    .foregroundStyle(.green)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.contentSecondary)
                            }
                            .fontWeight(.semibold)
                            
                        } else {
                            HStack {
                                Text(exchange.otherCurrency + " to " + exchange.plnCurrency)
                                
                                Spacer()
                                
                                Text("-\(exchange.otherAmount.formatted(.currency(code: exchange.otherCurrency)))")
                                    .foregroundStyle(.red)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.contentSecondary)
                            }
                            .fontWeight(.semibold)
                            
                        }
                    }
                }
            }
            .foregroundStyle(.white)
            .padding()
            .onAppear {
                Task {
                    await vm.fetchExchanges(by: account.id)
                }
            }
//            .navigationTitle(account.currencySymbol + " Account")
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let previewAccount = Account(
        id: "uniqueID-2",
        user_id: "1",
        currency: "American Dollar",
        currencySymbol: "USD",
        balance: 1234.00,
        createdAt: "2024-12-15T19:06:08.971Z"
    )
    
    
    return NavigationStack {
        AccountDetailView(account: previewAccount)
    }
}
