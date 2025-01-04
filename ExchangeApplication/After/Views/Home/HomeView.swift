//
//  HomeView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 29/12/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var rateModel: RateModel
    @EnvironmentObject private var accountModel: AccountModel
    @EnvironmentObject private var userModel: UserModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.contentPrimary.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        UserHeaderView(user: userModel.user)
                        
                        AccountScrollView(accounts: accountModel.accounts)
                            .onAppear {
                                Task {
                                    await accountModel.getAccounts()
                                }
                            }
                        
                        buttonSection // FIXME: Idk what to do but we can make it better than extension.
                        
                        TransferCalculator(rates: rateModel.rates, fromCode: $rateModel.code)
                            .onAppear {
                                Task {
                                    rateModel.rates = try await rateModel.get30RateData(from: rateModel.code)
                                }
                            }
                            .onChange(of: rateModel.code) { _, newValue in
                                Task {
                                    rateModel.rates = try await rateModel.get30RateData(from: rateModel.code)
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
        .environmentObject(RateModel(client: RateHTTPClient()))
        .environmentObject(AccountModel())
        .environmentObject(UserModel())
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
                        
                    NavigationLink(destination: ExchangeView()) {
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
