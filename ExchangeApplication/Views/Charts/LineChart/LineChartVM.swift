//
//  LineChartVM.swift
//  ExchangeApplication
//
//  Created by Huseyin on 27/12/2024.
//

import Foundation

enum CurrencyCode: String, CaseIterable, Identifiable {
    case USD, CHF, EUR, GBP, JPY, CZK, NOK
    var id: Self { self }
}

enum NSError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct LineChartData: Codable {
    let table: String
    let currency: String
    let code: String
    let rates: [Rate]
}

struct Rate: Codable, Identifiable {
    var id: String { no }
    let no: String
    let effectiveDate: String
    let bid: Double
    let ask: Double
}

class LineChartVM: ObservableObject {
    
    @Published var chartData: LineChartData?
    @Published var fromCode: CurrencyCode = .USD
    
    init() {
        Task {
            self.chartData = try await fetchLast30RateData(from: .USD)
        }
    }
    
    //FIXME: - Burasi eklenicek sonradan
//    func fetchCurrentRateData() async throws -> LineChartData {
//        guard let url = URL(string: "https://api.nbp.pl/api/exchangerates/rates/c/usd?format=json") else {
//            throw NSError.invalidURL
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw NSError.invalidResponse
//        }
//        
//        do {
//            let decodedData = try JSONDecoder().decode(LineChartData.self, from: data)
//            return decodedData
//        } catch {
//            throw NSError.invalidData
//        }
//    }
    
    func fetchLast30RateData(from: CurrencyCode) async throws -> LineChartData {
        guard let url = URL(string: "https://api.nbp.pl/api/exchangerates/rates/c/\(from)/last/30?format=json") else {
            print("0")
            throw NSError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("1")
            throw NSError.invalidResponse
        }
        
        do {
            let decodedData = try JSONDecoder().decode(LineChartData.self, from: data)
            return decodedData
        } catch {
            print("2")
            throw NSError.invalidData
        }
    }
    
    func customDateFormatter(inputDate: String) -> String {
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
    
    
    func positionForColor(datas: [Rate], date: String) -> Double {
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
