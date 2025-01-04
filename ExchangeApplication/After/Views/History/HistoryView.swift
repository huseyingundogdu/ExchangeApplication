//
//  HistoryView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 29/12/2024.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject private var model: ExchangeModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.contentPrimary.ignoresSafeArea()
                ScrollView {
                    Text("Exchange History")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(model.exchanges) { exchange in
                        NavigationLink(destination: ExchangeDetailView(exchange: exchange)) { ExchangeRow(exchange: exchange)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .onAppear {
                    Task {
                        try await model.loadExchanges()
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    HistoryView()
        .environmentObject(ExchangeModel(client: LocalHTTPClient()))
}


