//
//  LineChartView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 27/12/2024.
//

import SwiftUI
import Charts

struct LineChartView: View {
    
    @StateObject private var vm = LineChartVM()
    @State private var rawSelectedDate: String? = nil
    @State private var persistentDate: String? = nil
    @State var positionForNewColor = 0.999
    
    @State var fromValue: Double = 1
    @State var plnValue: Double = 0
    
    @State var selected: CurrencyCode = .USD
    
    
    @State private var isUpdating = false
    
    var body: some View {
        VStack {
            if let datas = vm.chartData {
                VStack {
                    VStack {
                        VStack {
                            HStack(spacing: 5) {
                                Chart {
                                    ForEach(datas.rates) { rate in
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
                                                
                                                if rawSelectedDate == persistentDate {
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
                                                                            Text(vm.customDateFormatter(inputDate: rawSelectedDate))
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
                                }
                                .foregroundStyle(.interactiveSecondary)
                                .chartXSelection(value: $rawSelectedDate)
                                .onAppear {
                                    if persistentDate == nil {
                                        if let lastDate = vm.chartData?.rates.last {
                                            persistentDate = lastDate.effectiveDate
                                        }
                                    }
                                }
                                .onChange(of: rawSelectedDate) { _, newValue in
                                    if let newValue = newValue {
                                        persistentDate = newValue
                                        positionForNewColor = vm.positionForColor(datas: datas.rates, date: newValue)
                                    } else if let lastDate = datas.rates.last?.effectiveDate {
                                        persistentDate = lastDate
                                        positionForNewColor = 0.999
                                    }
                                }
                                .chartYScale(domain: findMinRate(rates: datas.rates)...findMaxRate(rates: datas.rates))
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
                            }
                            
                            HStack {
                                Text(vm.customDateFormatter(inputDate: datas.rates[0].effectiveDate))
                                Spacer()
                                Text("Today")
                            }
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .padding(.top)
                            
                        }
                        Text("1 \(datas.code) = \(datas.rates[29].ask.formatted()) PLN") // FIXME: X to PLN , PLN to X
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical)
                            .foregroundStyle(.white)
                            .fontWeight(.heavy)
                    }
                    .frame(maxHeight: 250)
                    .padding()
                    .padding(.top, 50)

                    
                    VStack {
                        HStack {
                            TextField("0", value: $fromValue, format: .number)
                                .foregroundStyle(.white)
                                .font(.title)
                                .fontWeight(.bold)
                                .onChange(of: fromValue) { _, _ in
                                    calculatePLN()
                                }
                            
                            CustomPickerView(selectedCode: $vm.fromCode)
                                .buttonStyle(.plain)
                                .foregroundStyle(.interactiveSecondary)
                                .onChange(of: vm.fromCode) { _, newValue in
                                    Task {
                                        vm.chartData = try await vm.fetchLast30RateData(from: newValue)
                                    }
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
                .onAppear {
                    calculatePLN()
                }
            } else {
                // - If vm.chartData is nil
            }
        }
    }
    
    private func calculatePLN() {
        if let rate = vm.chartData?.rates.last {
            plnValue = fromValue * rate.ask
        }
    }
    
    private func findMaxRate(rates: [Rate]) -> Double {
        return rates.max(by: { $0.ask < $1.ask })?.ask ?? 1.0
    }
    
    private func findMinRate(rates: [Rate]) -> Double {
        rates.min(by: { $0.ask < $1.ask })?.ask ?? 0.0
    }
    
}

#Preview {
    LineChartView()
        .padding()
}
