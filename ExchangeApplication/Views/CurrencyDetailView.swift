//
//  CurrencyDetailView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 24/12/2024.
//

import SwiftUI
import Charts
///*
//    - Currency Detail
//    - Currency 7 day
//    - Buy Button?
// 
//*/
//
//struct CurrencyDetailView: View {
//    
//    var currency: Currency
//    var chartData: CurrencyChartData
//    
////    var rates = chartData.rates
////    
////    init(rates = chartData.rates)
//    
//    @State private var selectedRate: Rate? = nil
//    
//    var body: some View {
//        VStack {
//            Text(currency.code)
//            Text(currency.name)
//        }
//        .frame(maxWidth: .infinity, minHeight: 350)
//        .background(.red)
//       
//        VStack {
//            let rates = chartData.rates
//            let yValues = rates.map { $0.mid }
//            let yMin = (yValues.min() ?? 0) - 0.01 // FIXME: Find better solution
//            let yMax = (yValues.max() ?? 1) + 0.01 // FIXME: Find better solution
//            
//            let xValues = rates.compactMap { rate -> Date? in
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyy-MM-dd"
//                return formatter.date(from: rate.effectiveDate)
//            }
////            let xMin = xValues.min() ?? Date()
////            let xMax = xValues.max() ?? Date()
//            
//            GroupBox("Line Chart") {
//                
//                Text("Aasd")
//                
//                Chart {
//                    ForEach(chartData.rates, id: \.id) { rate in
//                        LineMark(
//                            x: .value("Date", convertToDate(rate.effectiveDate) ?? Date()),
//                            y: .value("Rate", rate.mid)
//                        )
//                        .lineStyle(StrokeStyle(lineWidth: 3))
//                        .symbol {
//                            Circle()
//                                .frame(width: 10, height: 10)
//                        }
//                    }
//                }
//                .frame(height: 300)
//                .chartYScale(domain: [yMin, yMax])
//            }
//            .padding()
//            
//        }
//        
//        Spacer()
//    }
//    
//    // Helper to convert string date to Date
//    private func convertToDate(_ dateString: String) -> Date? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter.date(from: dateString)
//    }
//}
//
//#Preview {
//    let previewCurrency = Currency(
//        code: "USD",
//        name: "Dollar",
//        buy: 4.0654,
//        sell: 3.9894,
//        date: "2024-11-18"
//    )
//    
//    let previewChartData = CurrencyChartData(
//        table: "A",
//        currency: "dolar amerykański",
//        code: "USD",
//        rates: [
//            Rate(
//                no: "243/A/NBP/2024",
//                effectiveDate: "2024-12-16",
//                mid: 4.0571
//            ),
//            Rate(
//                no: "244/A/NBP/2024",
//                effectiveDate: "2024-12-17",
//                mid: 4.0623
//            ),
//            Rate(
//                no: "245/A/NBP/2024",
//                effectiveDate: "2024-12-18",
//                mid: 4.0621
//            ),
//            Rate(
//                no: "246/A/NBP/2024",
//                effectiveDate: "2024-12-19",
//                mid: 4.0944
//            ),
//            Rate(
//                no: "247/A/NBP/2024",
//                effectiveDate: "2024-12-20",
//                mid: 4.1002
//            ),
//            Rate(
//                no: "248/A/NBP/2024",
//                effectiveDate: "2024-12-23",
//                mid: 4.095
//            ),
//            Rate(
//                no: "249/A/NBP/2024",
//                effectiveDate: "2024-12-24",
//                mid: 4.1127
//            )
//        ]
//    )
//    
//    
//    return CurrencyDetailView(currency: previewCurrency, chartData: previewChartData)
//}

//struct CurrencyChartData: Codable {
//    let table: String
//    let currency: String
//    let code: String
//    let rates: [Rate]
//    
//}
//struct Rate: Codable, Identifiable {
//    var id: String { no }
//    let no: String
//    let effectiveDate: String
//    let mid: Double
//}
//struct Rate: Codable, Identifiable {
//    var id: String { no }
//    var no: String
//    var effectiveDate: Date // Change this to Date
//    var mid: Double
//    
//    // Modify the initializer to accept a string and convert it to Date
//    init(no: String, effectiveDate: String, mid: Double) {
//        self.no = no
//        self.mid = mid
//        // Convert the string to Date using a DateFormatter
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd" // Match the date format
//        if let date = formatter.date(from: effectiveDate) {
//            self.effectiveDate = date
//        } else {
//            self.effectiveDate = Date() // Default to the current date if the conversion fails
//        }
//    }
//}

/*
 
 {
     "table": "A",
     "currency": "dolar amerykański",
     "code": "USD",
     "rates": [
         {
             "no": "243/A/NBP/2024",
             "effectiveDate": "2024-12-16",
             "mid": 4.0571
         },
         {
             "no": "244/A/NBP/2024",
             "effectiveDate": "2024-12-17",
             "mid": 4.0623
         },
         {
             "no": "245/A/NBP/2024",
             "effectiveDate": "2024-12-18",
             "mid": 4.0621
         },
         {
             "no": "246/A/NBP/2024",
             "effectiveDate": "2024-12-19",
             "mid": 4.0944
         },
         {
             "no": "247/A/NBP/2024",
             "effectiveDate": "2024-12-20",
             "mid": 4.1002
         },
         {
             "no": "248/A/NBP/2024",
             "effectiveDate": "2024-12-23",
             "mid": 4.095
         },
         {
             "no": "249/A/NBP/2024",
             "effectiveDate": "2024-12-24",
             "mid": 4.1127
         }
     ]
 }
 
*/
