//
//  HomeView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 29/12/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var currencyModel: CurrencyModel
    @EnvironmentObject private var accountModel: AccountModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.contentPrimary.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        //UserHeaderView(user: userModel.user)
                        
                        AccountScrollView(accounts: accountModel.accounts)
                            .onAppear {
                                Task {
                                    await accountModel.getAccounts()
                                }
                            }
                        
                        buttonSection // FIXME: Idk what to do but we can make it better than extension.
                        
                        TransferCalculator(rates: currencyModel.rates?.rates, fromCode: $currencyModel.code)
                            .onAppear {
                                Task {
                                    await currencyModel.getCurrencyRates(code: .USD)
                                }
                            }
                            .onChange(of: currencyModel.code) { _, newValue in
                                Task {
                                    await currencyModel.getCurrencyRates(code: currencyModel.code)
                                }
                            }
                        Rectangle()
                            .frame(height: 100)
                            .foregroundStyle(.contentPrimary)
                    }
                }
                .padding()
                .scrollIndicators(.hidden)
                .ignoresSafeArea(edges: .bottom)
            }
        }
        
    }
}

#Preview {
    HomeView()
        .environmentObject(CurrencyModel())
        .environmentObject(AccountModel())
}

extension HomeView {
    var buttonSection: some View {
        HStack(spacing: 5) {
            Button {
                
            } label: {
                HStack(spacing: 0) {
                    Image(systemName: "arrow.left.arrow.right")
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                        .clipShape(Circle())
                        .bold()
                        .padding(10)
                        
                    NavigationLink(destination: BuyView()) {
                        Text("Exchange")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .bold()
                    }
                }
                .padding(.trailing)
                .background(.interactiveSecondary)
                .clipShape(Capsule())
            }
            
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "plus")
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.interactiveSecondary)
                        .clipShape(Circle())
                        .bold()
                        .padding(10)
                    
                    Text("Deposit")
                        .font(.subheadline)
                        .foregroundStyle(.interactiveSecondary)
                }
                .padding(.trailing)
                .background(.interactivePrimary)
                .clipShape(Capsule())
            }
            Spacer()
            Button {
                
            } label: {
                VStack {
                    Image(systemName: "ellipsis")
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.interactiveSecondary)
                        .padding(10)
                        .background(.interactivePrimary)
                        .clipShape(Circle())
                        .rotationEffect(.degrees(90))
                }
            }
        }
    }
}
