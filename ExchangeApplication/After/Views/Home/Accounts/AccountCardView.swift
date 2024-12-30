//
//  AccountCardView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 21/12/2024.
//

import SwiftUI

struct AccountCardView: View {
    
    var account: Account
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                
                Image(account.currencySymbol)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fill)
                
                Text(account.currencySymbol)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            Spacer()
            
            HStack(spacing: 2) {
                Image(systemName: "building.columns.fill")
                    .foregroundStyle(.white)
                Text("··· " + account.id)
                    .foregroundStyle(.white)
            }
            Text("\(account.balance.formatted())")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
        .frame(width: 220, height: 150, alignment: .topLeading)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.contentSecondary)
        }
    }
}

#Preview {
    AccountCardView(account: Account(
        id: "uniqueID-0",
        user_id: "1",
        currency: "Polish Zloty",
        currencySymbol: "PLN",
        balance: 234.12,
        createdAt: "2024-12-15T19:06:08.971Z")
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
