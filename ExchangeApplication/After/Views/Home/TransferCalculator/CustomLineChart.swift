//
//  TransferCalculator.swift
//  ExchangeApplication
//
//  Created by Huseyin on 28/12/2024.
//

import SwiftUI
import Charts

struct CustomLineChart: View {
    
    var rates: Rates?
    
    @State private var rawSelectedDate: String? = nil
    @State private var persistentDate: String? = nil
    @State var positionForNewColor = 0.999
    
    var body: some View {
        if let rates = rates {
            Chart {
                ForEach(rates) { rate in
                    LineMark(
                        x: .value("Date", rate.effectiveDate),
                        y: .value("Rate", rate.ask)
                    )
                    .foregroundStyle(
                        .linearGradient(
                            Gradient(
                                stops: [
                                    .init(color: .interactiveSecondary, location: 0),
                                    .init(color: .interactiveSecondary, location: positionForNewColor),
                                    .init(color: .gray, location: positionForNewColor),
                                    .init(color: .gray, location: 1),
                                ]),
                            startPoint: .leading,
                            endPoint: .trailing)
                    )
                    
                    if let persistentDate {
                        if persistentDate == rate.effectiveDate {
                            PointMark( 
                                x: .value("Date", persistentDate),
                                y: .value("Rate", rate.ask)
                            )
                            .symbol {
                                Circle()
                                    .strokeBorder(.black, lineWidth: 1)
                                    .frame(width: 10, height: 10)
                                    .background {
                                        Circle()
                                            .foregroundStyle(.interactiveSecondary)
                                            .background {
                                                Circle()
                                                    .frame(width: 30, height: 30)
                                                    .opacity(0.3)
                                            }
                                    }
                            }
                            
                            RuleMark(x: .value("Selected Date", persistentDate))
                                .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                                .foregroundStyle(.gray.opacity(0.5))
                                .annotation(
                                    position: .top,
                                    spacing: 10,
                                    overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                                        if let rawSelectedDate {
                                            VStack {
                                                HStack {
                                                    Text("\(rate.ask.formatted()) PLN")
                                                        .foregroundStyle(.interactiveSecondary)
                                                    Text(customDateFormatter(inputDate: rawSelectedDate))
                                                        .foregroundStyle(.white)
                                                }
                                            }
                                            .padding(8)
                                            .background(.gray.opacity(0.5))
                                            .clipShape(Capsule())
                                        }
                                    }
                            
                        }
                    }
                }
            }
            .foregroundStyle(.interactiveSecondary)
            .chartXSelection(value: $rawSelectedDate)
            .onAppear {
                if persistentDate == nil {
                    if let lastRate = rates.last {
                        persistentDate = lastRate.effectiveDate
                    }
                }
            }
            .onChange(of: rawSelectedDate) { _, newValue in
                if let newValue = newValue {
                    persistentDate = newValue
                } else if let lastDate = rates.last?.effectiveDate {
                    persistentDate = lastDate
                }
            }
            .chartYScale(domain: findMinRate(rates: rates)...findMaxRate(rates: rates))
            .chartYAxis {
                AxisMarks(values: .automatic(desiredCount: 3)) {
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundStyle(.gray.opacity(0.5))
                    AxisValueLabel()
                        .foregroundStyle(.white)
                        .font(.caption)
                }
            }
            .chartXAxis(.hidden)
            
        } else {
            Text("Error")
        }
    }
    
    
    // Helper Functions
    
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
    
    private func findMaxRate(rates: Rates) -> Double {
        return rates.max(by: { $0.ask < $1.ask })?.ask ?? 1.0
    }
    
    private func findMinRate(rates: Rates) -> Double {
        rates.min(by: { $0.ask < $1.ask })?.ask ?? 0.0
    }
    
    private func positionForColor(datas: Rates, date: String) -> Double {
        var position = 0.999
        var colorIndex = 30
        
        for (index, data) in datas.enumerated() {
            if data.effectiveDate == date {
                colorIndex = index
            }
        }
        
        position = (Double(colorIndex) * 0.03444828)
        
        return position
    }
    
}

#Preview {
    CustomLineChart(rates: Constants.MockData.rates)
        .padding()
}
