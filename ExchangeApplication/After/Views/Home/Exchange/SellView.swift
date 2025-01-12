//
//  SellView.swift
//  ExchangeApplication
//
//  Created by Hüseyin Gündoğdu on 10/01/2025.
//

import SwiftUI

struct SellView: View {
    @EnvironmentObject var currencyModel: CurrencyModel
    @EnvironmentObject var accountModel: AccountModel
    // rate
    // account
    let accountBalance: Double = 100 // Limit - bunu account olarak da getirtebiliriz cunku pln accountunada ihtiyacimiz var exchange operations icin
    @State private var amount: Double = 0
    @State private var result: Double = 0
    @State var code: CurrencyCode = .USD
    
    @State var accountID: String = ""
    
    var body: some View {
        VStack {
            Text("How much would you like to sell? \(accountID)")
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.heavy)
            
            Spacer()
            
            VStack {
                HStack {
                    TextField("0", value: $amount, format: .number)
                    
                    Text("\(accountBalance.formatted())")
                        .foregroundStyle(.contentSecondary)
                    Text(code.rawValue)
                }
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()
                .background(.contentPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                HStack(alignment: .top) {
                    VStack(spacing: 10) {
                        Image(systemName: "x.circle.fill")
                        Image(systemName: "equal.circle.fill")
                    }
                    Text("\((currencyModel.currency?.sell ?? 0).formatted())") // Current Rate
                    Spacer()
                    Text("Rate")
                }
                .font(.title3)
                .italic()
                .foregroundStyle(.white)
                .padding()
                
                HStack {
                    Text("\((amount * (currencyModel.currency?.sell ?? 0)).formatted())")
                        .foregroundStyle(.white)
                    Spacer()
                    Text("PLN")
                }
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()
                .background(.contentPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                
                Spacer()
            }
            .padding()
            .frame(maxHeight: UIScreen.main.bounds.height/3)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.contentSecondary)
            }
            
            Spacer()
            
            
            Button("Sell") {
                // TODO: - Sell Operation
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(accountBalance >= amount ? .interactiveSecondary : .red.opacity(0.3))
            .foregroundStyle(accountBalance >= amount ? .white : .gray)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .allowsHitTesting(accountBalance >= amount)
        }
        .onAppear {
            Task {
                await currencyModel.getCurrencyByCode(code: code)
                accountID = await accountModel.getPLNAccountID() ?? "error"
            }
        }
        .padding()
        .background(.contentPrimary)
    }
    
}

#Preview {
    SellView()
        .environmentObject(CurrencyModel())
}
