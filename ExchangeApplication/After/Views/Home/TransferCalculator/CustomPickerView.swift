//
//  CustomPickerView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 27/12/2024.
//

import SwiftUI

struct CustomPickerView: View {
    
    @Binding var selectedCode: CurrencyCode
    @State var showingSheet = false
    
    var body: some View {
        VStack {

            Button{
                showingSheet.toggle()
            } label: {
                HStack {
                    Text(selectedCode.rawValue)
                        .font(.title)
                        .fontWeight(.semibold)
                    Image(systemName: "chevron.down")
                        .bold()
                }
            }
        }
        .sheet(isPresented: $showingSheet) {
            List {
                ForEach(CurrencyCode.allCases) { code in

                    Button {
                        selectedCode = code
                        showingSheet = false
                    } label: {
                        HStack(spacing: 20) {
                            Image(code.rawValue)
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text(code.rawValue)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                    }
                    .listRowBackground(code == selectedCode ? Color.interactivePrimary : Color.contentPrimary)
                }
            }
            .listStyle(.plain)
            .background(Color.contentPrimary)
        }
    }
}

#Preview {
    CustomPickerView(selectedCode: .constant(.USD))
}
