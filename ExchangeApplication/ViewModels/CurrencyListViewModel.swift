//
//  CurrencyListViewModel.swift
//  ExchangeApplication
//
//  Created by Huseyin on 28/11/2024.
//

import Foundation

class CurrencyListViewModel: ObservableObject {
    private var service = LocalService()
    
    @Published var currencies: [Currency] = [Currency]()
    
    func fetchCurrencies() async {
        do {
            currencies = try await service.fetchCurrencies()
        } catch {
            print(error.localizedDescription)
        }
    }
}
