//
//  ExchangeView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 01/01/2025.
//

import SwiftUI

struct ExchangeView: View {
    // rate
    // account
    
    @State private var amount: Double = 0
    @State private var result: Double = 0
    @State private var code: CurrencyCode = .USD
    
    var body: some View {
        VStack {
            Text("How much would you like to exchange?")
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.heavy)
            
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
                    Text("4.123") // Current Rate
                    Spacer()
                    Text("Rate")
                }
                .font(.title3)
                .italic()
                .foregroundStyle(.white)
                .padding()
                
                
                
                
                HStack {
                    Text("\(result.formatted())")
                        .foregroundStyle(.white)
                    Spacer()
                    CustomPickerView(selectedCode: $code)
                        .foregroundStyle(.interactiveSecondary)
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
            
            Button("Exchange") {
                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.interactiveSecondary)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
        }
        .padding()
        .background(.contentPrimary)
    }
}

#Preview {
    ExchangeView()
}
