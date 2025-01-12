//
//  ExchangeRow.swift
//  ExchangeApplication
//
//  Created by Huseyin on 30/12/2024.
//

import SwiftUI

struct ExchangeRow: View {
    
    var exchange: Exchange
    
    var body: some View {
        HStack {
            if exchange.operation == "buy" {
                Text(exchange.plnCurrency)
                Text("\(exchange.plnAmount.formatted())")
                Image(systemName: "arrow.left.arrow.right")
                    .foregroundStyle(.interactiveSecondary)
                Text(exchange.otherCurrency)
                Text("\(exchange.otherAmount.formatted())")
            } else {
                Text(exchange.otherCurrency)
                Text("\(exchange.otherAmount.formatted())")
                Image(systemName: "arrow.left.arrow.right")
                    .foregroundStyle(.interactiveSecondary)
                Text(exchange.plnCurrency)
                Text("\(exchange.plnAmount.formatted())")
            }
            
            Spacer()
            Text("\(exchange.currencyRate.formatted())")
                .font(.subheadline)
                .fontWeight(.light)
        }
        .font(.title2)
        .fontWeight(.semibold)
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.contentSecondary.opacity(0.5))
        }
        .foregroundStyle(.white)
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
    return ExchangeRow(exchange: previewExchange)
}
