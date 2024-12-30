//
//  RateHttpClient.swift
//  ExchangeApplication
//
//  Created by Huseyin on 29/12/2024.
//

import Foundation

class RateHTTPClient {
    func fetchLast30RateData(from: CurrencyCode) async throws -> Rates {
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
            let decodedData = try JSONDecoder().decode(LineChartDataX.self, from: data)
            return decodedData.rates
        } catch {
            print("223")
            throw NSError.invalidData
        }
    }
}
