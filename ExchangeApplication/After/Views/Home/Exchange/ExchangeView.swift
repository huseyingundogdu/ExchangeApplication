//
//  ExchangeView.swift
//  ExchangeApplication
//
//  Created by Hüseyin Gündoğdu on 13/01/2025.
//

import SwiftUI

struct ExchangeView: View {
    @EnvironmentObject var accountModel: AccountModel
    @EnvironmentObject var exchangeModel: ExchangeModel
    @EnvironmentObject var currencyModel: CurrencyModel
    @Environment(\.dismiss) var dismiss
    
    @State private var amount: Double = 0 // PLN
    @State private var result: Double = 0 // OTH
    @State private var buy: Bool = true // State to track the swap
    
    var accountID: String = ""
    
    @State private var plnAccount: Account?
    @State private var account: Account?
    
    var body: some View {
        ZStack {
            Color.contentPrimary.ignoresSafeArea()
            VStack(spacing: 0) {
                ZStack {
                    // First TextField
                    HStack {
                        TextField("0", value: $amount, format: .number)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .allowsHitTesting(buy)
                            .onChange(of: amount) { _, _ in
                                if buy {
                                    updateResult()
                                }
                            }
                        
                        if let plnAccount = plnAccount {
                            Text(buy
                                 ? "\(plnAccount.balance.formatted()) \(plnAccount.currencySymbol)"
                                 : "\(plnAccount.currencySymbol)"
                            )
                            .font(.title3)
                            .foregroundStyle(.interactiveSecondary)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(.contentPrimary))
                    .offset(y: buy ? -45 : 45) // Move down when swapped
                    .animation(.easeInOut(duration: 0.4), value: buy)
                    
                    
                    // Second TextField
                    HStack {
                        
                        TextField("0", value: $result, format: .number)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .allowsHitTesting(!buy)
                            .onChange(of: result) { _, _ in
                                if !buy {
                                    updateAmount()
                                }
                            }
                        
                        if let account = account {
                            Text(buy
                                 ? "\(account.currencySymbol)"
                                 : "\(account.balance.formatted()) \(account.currencySymbol)"
                            )
                            .font(.title3)
                            .foregroundStyle(.interactiveSecondary)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(.contentPrimary))
                    .offset(y: buy ? 45 : -45) // Move up when swapped
                    .animation(.easeInOut(duration: 0.4), value: buy)
                    
                    Button {
                        buy.toggle() // Toggle swap state
                        //print(buy)
                        if currencyModel.currency != nil {
                            if buy {
                                amount = 0
                            } else {
                                result = 0
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(.interactiveSecondary)
                            .background(.contentPrimary)
                            .clipShape(Circle())
                            .padding()
                    }
                }
                .frame(height: 180) // Total height to accommodate both positions
                .padding()
                
                
                HStack {
                    Image(systemName: "x.circle.fill")
                        .foregroundStyle(.white)
                    
                    if let currency = currencyModel.currency {
                        Text(buy ? "\(currency.buy.formatted())" : "\(currency.sell.formatted())")
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    
                    Text("Current Rate")
                        .italic()
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                
                
                Button(buy ? "BUY" : "SELL") {
                    performExchange()
                    //dismiss()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 12).fill(buttonIsEnabled() ? .interactiveSecondary : .gray))
                .foregroundStyle(buttonIsEnabled()
                                 ? .interactivePrimary
                                 : .black
                )
                .allowsHitTesting(buttonIsEnabled())
                .padding()
                
                
            }
            .background(RoundedRectangle(cornerRadius: 12).fill(.contentSecondary))
            .padding()
        }
        .alert(exchangeModel.resultMessage, isPresented: $exchangeModel.hasInfo, actions: {
            Button("OK") {
                exchangeModel.hasInfo = false
                dismiss()
            }
        })
        .task {
            await loadAccounts()
        }
    }
    
    private func buttonIsEnabled() -> Bool {
        if let plnAccount = plnAccount, let account = account {
            if buy {
                if amount <= plnAccount.balance {
                    return true
                }
                return false
            } else {
                if result <= account.balance {
                    return true
                }
                return false
            }
        }
        return false
    }
    
    private func updateAmount() {
        if let currency = currencyModel.currency {
            amount = result * (buy ? (1 / currency.sell) : currency.sell)
        }
    }
    
    private func updateResult() {
        if let currency = currencyModel.currency {
            result = amount * (buy ? (1 / currency.buy) : currency.buy)
        }
    }
    
    private func getRates() async {
        if let account = account {
            await currencyModel.getCurrencyByCode(code: CurrencyCode(rawValue: account.currencySymbol) ?? .USD)
        }
    }
    
    private func loadAccounts() async {
        let plnAccountID = await accountModel.getPLNAccountID() ?? ""
        if let plnAccount = await accountModel.fetchAccount(id: plnAccountID) {
            self.plnAccount = plnAccount
        }
        if let account = await accountModel.fetchAccount(id: accountID) {
            self.account = account
            await getRates()
        }
    }
    
    private func performExchange() {
        guard let pln = plnAccount, let oth = account else { return }
        
        let amountToExchange = result // burasi degisti !!!!!
        let operationType = buy ? "BUY" : "SELL"
        
//        print("buy bool: \(buy)")
//        print("amount: \(amountToExchange)")
//        print("operation: \(operationType)")
        
        Task {
//            await exchangeModel.postExchange(
//                plnAccount_id: pln.id,
//                otherAccount_id: oth.id,
//                amount: amountToExchange,
//                operation: operationType) { _ in
//            }
            await exchangeModel.postExchange2(
                plnAccount_id: pln.id,
                otherAccount_id: oth.id,
                amount: amountToExchange,
                operation: operationType
            )
        }
    }
}
