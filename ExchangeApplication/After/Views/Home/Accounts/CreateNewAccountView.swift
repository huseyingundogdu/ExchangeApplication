//
//  CreateNewAccountView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 21/12/2024.
//

import SwiftUI

struct CreateNewAccountView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var accountModel: AccountModel
    @State private var code: CurrencyCode = .USD
    @State private var isShowingSheet = false
    
    var body: some View {
        ZStack {
            Color.contentPrimary.ignoresSafeArea()
            VStack(spacing: 35) {
                Text("Please select a currency")
                    .foregroundStyle(.interactiveSecondary)
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Image(code.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                    
                    Spacer()
                    
                    CustomPickerView(selectedCode: $code, showingSheet: isShowingSheet)
                        .foregroundStyle(.interactiveSecondary)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(.contentSecondary))
                
                
                Spacer()
                
                Button("Create Account") {
                    Task {
                        await accountModel.createAccount(code: code)
                        dismiss()
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.interactiveSecondary)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding()
        }
    }
}

#Preview {
    CreateNewAccountView()
}
