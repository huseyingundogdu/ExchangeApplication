//
//  ExchangeStore.swift
//  ExchangeApplication
//
//  Created by Hüseyin Gündoğdu on 09/01/2025.
//

import Foundation

@MainActor
class CurrencyModel: ObservableObject {
    
    @Published var currency: Currency?
    @Published var rates: LineChartDataX?
    @Published var code: CurrencyCode = .USD
    
    private let webservice = Webservice() // init
    
    func getCurrencyByCode(code: CurrencyCode) async {
        do {
            let response = try await webservice.request(
                endpoint: "/currency/id/\(code.rawValue.lowercased())",
                method: "GET",
                responseType: Currency.self
            )
            
            DispatchQueue.main.async {
                self.currency = response
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getCurrencyRates(code: CurrencyCode) async {
        do {
            let response = try await webservice.request(
                endpoint: "/currency/table/period/\(code.rawValue)",
                method: "GET",
                responseType: LineChartDataX.self
            )
            
            DispatchQueue.main.async {
                self.rates = response
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
