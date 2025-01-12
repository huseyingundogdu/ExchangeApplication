//
//  ExchangeView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 01/01/2025.
//

import SwiftUI

struct BuyView: View {
    @EnvironmentObject var currencyModel: CurrencyModel
//    @EnvironmentObject var accountModel: 
    // rate
    // account
    
    @State private var amount: Double = 0
    @State private var result: Double = 0
    @State private var code: CurrencyCode = .USD
    
    var body: some View {
        VStack {
            Text("How much would you like to buy?")
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.heavy)
            
            Spacer()
            
            VStack {
                HStack {
                    TextField("0", value: $amount, format: .number)
                    Text("PLN")
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
                    Text("\((currencyModel.currency?.buy ?? 0).formatted())") // Current Rate
                    Spacer()
                    Text("Rate")
                }
                .font(.title3)
                .italic()
                .foregroundStyle(.white)
                .padding()
                
                
                
                
                HStack {
                    Text("\((amount * (currencyModel.currency?.buy ?? 0)).formatted())")
                        .foregroundStyle(.white)
                    Spacer()
                    CustomPickerView(selectedCode: $code)
                        .foregroundStyle(.interactiveSecondary)
                        .onChange(of: code) { _, newValue in
                            Task {
                                await currencyModel.getCurrencyByCode(code: code)
                            }
                        }
                }
                .font(.title)
                .fontWeight(.bold)
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
            
            Button("Buy") {
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.interactiveSecondary)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
        }
        .onAppear {
            Task {
                await currencyModel.getCurrencyByCode(code: code)
            }
        }
        .padding()
        .background(.contentPrimary)
    }
    
}

#Preview {
    BuyView()
        .environmentObject(CurrencyModel())
}
