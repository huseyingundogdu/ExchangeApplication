//
//  TransferCalculator.swift
//  ExchangeApplication
//
//  Created by Huseyin on 29/12/2024.
//

import SwiftUI

struct TransferCalculator: View {
    var rates: Rates? = Constants.MockData.rates
    @Binding var fromCode: CurrencyCode
    @State var fromValue: Double = 0
    @State var plnValue: Double = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Transfer Calculator")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            VStack {
                VStack {
                    CustomLineChart(rates: rates)
                        .frame(maxHeight: 250)
                    
                    HStack {
                        Text(customDateFormatter(inputDate: rates?.last?.effectiveDate ?? ""))
                        Spacer()
                        Text("Today")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.white)
                }
                .padding(.top, 40)
                .padding()
                
                if let lastRate = rates?.last  {
                    Text("1 " + fromCode.rawValue + " = \(lastRate.ask) PLN")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.white)
                        .fontWeight(.heavy)
                        .padding(.horizontal)
                }
                
                VStack {
                    HStack {
                        TextField("0", value: $fromValue, format: .number)
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .onChange(of: fromValue) { _, _ in
                                calculatePLN()
                            }
                        
                        CustomPickerView(selectedCode: $fromCode)
                                                .buttonStyle(.plain)
                                                .foregroundStyle(.interactiveSecondary)
                                                .onChange(of: fromCode) { _, newValue in
                                                    fromCode = newValue
//                                                    calculatePLN() // TEST
                                                    fromValue = 0
                                                    plnValue = 0
                                                }
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.contentPrimary)
                    }
                    HStack {
                        TextField("0", value: $plnValue, format: .number)
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .disabled(true)
                        Text("PLN")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.semibold)
                        Image(systemName: "minus")
                            .foregroundStyle(.white)
                            .bold()
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.contentPrimary)
                    }
                }
                .padding()
            }
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.contentSecondary)
            }
        }
        .onAppear { // .onappear
            calculatePLN()
        }
    }
    
    // Helper Function
    
    private func calculatePLN() {
        if let rate = rates?.last {
            plnValue = fromValue * rate.ask
        }
    }
    
    private func customDateFormatter(inputDate: String) -> String {
        let inputDateFormat = "yyyy-MM-dd"
        let outputDateFormat = "dd MMM"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputDateFormat
        
        if let date = dateFormatter.date(from: inputDate) {
            dateFormatter.dateFormat = outputDateFormat
            let formattedDateString = dateFormatter.string(from: date)
            return formattedDateString
        } else {
            return "Error"
        }
    }
}

#Preview {
    TransferCalculator(fromCode: .constant(CurrencyCode.USD))
//        .environmentObject(RateModel(client: RateHTTPClient()))
        .padding()
        .background(.contentPrimary)
}
