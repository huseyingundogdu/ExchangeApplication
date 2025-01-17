//
//  WealthView.swift
//  ExchangeApplication
//
//  Created by Hüseyin Gündoğdu on 14/01/2025.
//

import SwiftUI
import Charts

struct WealthAccount: Identifiable {
    var id: String
    var currencySymbol: String
    var plnBalance: Double
    var balance: Double
}

struct WealthView: View {
    @EnvironmentObject var currencyModel: CurrencyModel
    @EnvironmentObject var accountModel: AccountModel
    
    @State private var selectedBalance: Double?
    @State private var selectedAccount: WealthAccount?
    @State private var wealthAccounts: [WealthAccount] = []
    @State private var isLoading = true // Added to track loading state
    
    var totalBalance = 123.123
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.contentPrimary.ignoresSafeArea()
                VStack {
                    
                    Text("Wealth Portfolio")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if isLoading { // Show loading until the data is ready
                        Circle()
                            .fill(.contentSecondary)
                            .unredacted()
                            .overlay {
                                ZStack {
                                    Circle()
                                        .fill(.contentPrimary)
                                        .frame(width: 175)
                                        .padding()
                                        .padding()
                                    ProgressView()
                                }
                            }
                        
                    } else {
                        
                        Chart(wealthAccounts, id: \.id) { account in
                            SectorMark(
                                angle: .value("Balance", account.plnBalance),
                                innerRadius: .ratio(0.6),
                                outerRadius: selectedAccount?.id == account.id ? 175 : 150,
                                angularInset: 2
                            )
                            .annotation(position: .overlay) {
                                Text(account.currencySymbol)
                                    .fontWeight(.heavy)
                                    .foregroundStyle(.white)
                            }
                            .cornerRadius(6)
                            .foregroundStyle(.interactiveSecondary)
                            //.foregroundStyle(by: .value("ID", account.id)) -> Colorful
                            .opacity(selectedAccount?.id == account.id ? 1 : 0.5)
                        }
                        .chartLegend(.hidden)
                        .chartBackground { chartProxy in
                            GeometryReader { geometry in
                                if let anchor = chartProxy.plotFrame {
                                    let frame = geometry[anchor]
                                    VStack {
                                        if let selectedAccount = selectedAccount {
                                            Text("\(selectedAccount.balance.formatted(.number.precision(.fractionLength(2)))) \(selectedAccount.currencySymbol)")
                                                .font(.callout)
                                                .foregroundStyle(.gray)
                                                .bold()
                                        } else {
                                            Text("Total")
                                                .font(.callout)
                                                .foregroundStyle(.gray)
                                                .bold()
                                        }
                                        
                                        Text("\((selectedAccount?.plnBalance ?? calculateTotalBalance()).formatted(.number.precision(.fractionLength(2)))) PLN")
                                            .font(.title.bold())
                                            .foregroundStyle(.white)
                                    }
                                    .position(x: frame.midX, y: frame.midY)
                                }
                            }
                        }
                        .chartAngleSelection(value: $selectedBalance)
                        .aspectRatio(contentMode: .fit)
                        
                    }
                    Spacer()
                    Text("All Exchanges")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView {
                        ForEach(accountModel.exchanges) { exchange in
                            NavigationLink(destination: ExchangeDetailView(exchange: exchange)) {
                                ExchangeRow(exchange: exchange)
                            }
                        }
                    }
                    
                }
                .onChange(of: selectedBalance, { oldValue, newValue in
                    if let newValue {
                        withAnimation {
                            getSelectedAccount(value: newValue)
                        }
                    } else {
                        withAnimation {
                            selectedAccount = nil
                        }
                    }
                })
                .padding()
                
            }
            .task {
                wealthAccounts = []
                isLoading = true
                await loadWealthAccounts()
                await accountModel.getAllExchanges()
            }
        }
    }
    
    private func loadWealthAccounts() async {
        var accounts: [WealthAccount] = []
        
        // Use TaskGroup for concurrent fetching of currencies
        await withTaskGroup(of: WealthAccount?.self) { group in
            for account in accountModel.accounts {
                group.addTask {
                    if account.currencySymbol != "PLN" {
                        await currencyModel.getCurrencyByCode(code: CurrencyCode(rawValue: account.currencySymbol) ?? .USD)
                        return await WealthAccount(
                            id: account.id,
                            currencySymbol: account.currencySymbol,
                            plnBalance: account.balance * (currencyModel.currency?.sell ?? 1),
                            balance: account.balance
                        )
                    } else {
                        return WealthAccount(
                            id: account.id,
                            currencySymbol: account.currencySymbol,
                            plnBalance: account.balance,
                            balance: account.balance
                        )
                    }
                }
            }
            
            // Collect results from the task group
            for await wealthAccount in group {
                if let wealthAccount = wealthAccount {
                    accounts.append(wealthAccount)
                }
            }
        }
        
        // Update properties on the main thread
        DispatchQueue.main.async {
            self.wealthAccounts = accounts.sorted { $0.currencySymbol < $1.currencySymbol }
            
            // Delay the toggle of isLoading for a brief moment to allow the view to update
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isLoading = false
            }
        }
    }
    
    private func calculateTotalBalance() -> Double {
        return wealthAccounts.reduce(0) { $0 + $1.plnBalance }
    }
    
    private func getSelectedAccount(value: Double) {
        var cumulativeTotal: Double = 0
        let account = wealthAccounts.first { account in
            cumulativeTotal += account.plnBalance
            if value <= cumulativeTotal {
                selectedAccount = account
                return true
            }
            return false
        }
    }
}
