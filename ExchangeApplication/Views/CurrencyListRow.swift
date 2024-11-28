//
//  CurrencyListRow.swift
//  ExchangeApplication
//
//  Created by Huseyin on 28/11/2024.
//

import SwiftUI

struct CurrencyListRow: View {
    var currency: Currency
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(currency.code)
                    .font(.largeTitle)
                    .bold()
                
                Text(currency.name)
            }
            
            Spacer()
            
            VStack {
                HStack {
                    Text("Buy")
                        .bold()
                    Text("\(currency.buy.formatted())")
                }
                .foregroundStyle(.green)

                HStack {
                    Text("Sell")
                        .bold()
                    Text("\(currency.sell.formatted())")
                }
                .foregroundStyle(.red)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let currency = Currency(code: "USD", name: "Dollar", buy: 4.0654, sell: 3.9894, date: "2024-11-18")
    return CurrencyListRow(currency: currency)
}
