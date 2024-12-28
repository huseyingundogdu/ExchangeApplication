//
//  ContentView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 14/11/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
            ZStack {
                Color.contentPrimary.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        // MARK: - User Info Section
                        UserHeaderView()
                        // MARK: - Balance and Accounts Section
                        AccountScrollView()
                        // MARK: - Buttons Section
                        buttonSection // FIXME: Idk what to do but we can make it better than extension.
                        
                        //MARK: - Rate Converter
                        
                        Text("Transfer Calculator")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        LineChartView()
                        
                        // MARK: - Currency List View
//                        CurrencyListView()
                    }
                }
                .padding()
                .scrollIndicators(.hidden)
                .ignoresSafeArea(edges: .bottom)
            }
        
        
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    var buttonSection: some View {
        HStack(spacing: 5) {
            Button {
                
            } label: {
                HStack(spacing: 0) {
                    Image(systemName: "arrow.left.arrow.right")
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                        .clipShape(Circle())
                        .bold()
                        .padding(10)
                        
                    
                    Text("Exchange")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .bold()
                }
                .padding(.trailing)
                .background(.interactiveSecondary)
                .clipShape(Capsule())
            }
            
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "plus")
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.interactiveSecondary)
                        .clipShape(Circle())
                        .bold()
                        .padding(10)
                    
                    Text("Deposit")
                        .font(.subheadline)
                        .foregroundStyle(.interactiveSecondary)
                }
                .padding(.trailing)
                .background(.interactivePrimary)
                .clipShape(Capsule())
            }
            Spacer()
            Button {
                
            } label: {
                VStack {
                    Image(systemName: "ellipsis")
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.interactiveSecondary)
                        .padding(10)
                        .background(.interactivePrimary)
                        .clipShape(Circle())
                        .rotationEffect(.degrees(90))
                }
            }
        }        
    }
}
