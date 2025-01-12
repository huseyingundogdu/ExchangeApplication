//
//  ExchangeDetailView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 30/12/2024.
//

import SwiftUI

struct ExchangeDetailView: View {
    
    var exchange: Exchange
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.contentSecondary
                Color.contentPrimary
                    .clipShape(
                        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 24, topTrailing: 24), style: .continuous)
                    )
                    .background(.contentSecondary)
                    .frame(height: UIScreen.main.bounds.height / (6.5/4))
            }
            .ignoresSafeArea()
            
            VStack {
                VStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 75, height: 75)
                        .overlay {
                            Image(systemName: "arrow.left.and.right")
                                .font(.title)
                                .foregroundStyle(.white)
                        }
                    
                    HStack {
                        Text("\(exchange.otherAmount.formatted())")
                        Text("\(exchange.otherCurrency)")
                    }
                    .font(.title)
                    .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height / 4)
                
                
                VStack {
                    Text("Exchange Details")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 20)
                    
                    VStack(spacing: 20) {
                        HStack {
                            Text("Amount")
                            Spacer()
                            Text("\(exchange.plnAmount.formatted()) \(exchange.plnCurrency)")
                        }
                        HStack {
                            Text("Rate")
                            Spacer()
                            Text("1 \(exchange.otherCurrency) = \(exchange.currencyRate.formatted()) \(exchange.plnCurrency)")
                        }
                        Divider()
                            .background(.white)
                        HStack {
                            Text("Result")
                            Spacer()
                            Text("\(exchange.otherAmount.formatted()) \(exchange.otherCurrency)")
                                .font(.title)
                                .fontWeight(.heavy)
                        }
                        Divider()
                            .background(.white)
                        HStack {
                            Text("Date")
                            Spacer()
                            Text("\(exchange.exchangeDate)")
                        }
                    }
                    .font(.title2)
                    .fontWeight(.semibold)
                }
                Spacer()
            }
            .foregroundStyle(.white)
            .padding()
        }
    }
}

#Preview {
    let previewExchange = Exchange(
        id: "1",
        pln_account_id: "uniqueID-PLN-1",
        other_account_id: "uniqueID-USD-3",
        plnAmount: 100,
        plnCurrency: "PLN",
        otherAmount: 25,
        otherCurrency: "USD",
        operation: "buy",
        currencyRate: 4.245,
        transactionFee: 0,
        exchangeDate: "2024-12-15T19:06:08.955Z")
    return NavigationStack {
        ExchangeDetailView(exchange: previewExchange)
    }
            
    
}
