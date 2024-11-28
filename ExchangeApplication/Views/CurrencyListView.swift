//
//  CurrencyListView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 28/11/2024.
//

import SwiftUI

struct CurrencyListView: View {
    @StateObject private var vm = CurrencyListViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("All Coins")
                .font(.title)
                .bold()
                .padding(.bottom, 10)
                
//            List(vm.currencies, id: \.code) { currency in
//                CurrencyListRow(currency: currency)
//            }
             
            Divider()
            ForEach(vm.currencies, id: \.code) { currency in
                CurrencyListRow(currency: currency)
                Divider()
            }
        }
        .task {
            await vm.fetchCurrencies()
        }
    }
}

#Preview {
    ScrollView {
        CurrencyListView()
    }
}
