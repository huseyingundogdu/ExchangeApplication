//
//  ExchangeHTTPClient.swift
//  ExchangeApplication
//
//  Created by Huseyin on 30/12/2024.
//

import Foundation

class LocalHTTPClient {
    private func fetch<T: Decodable>(_ resource: String) async throws -> T {
        guard let path = Bundle.main.path(forResource: resource, ofType: "json") else {
            print("path error")
            fatalError("path")
        }
        
        let data = try Data(contentsOf: URL(filePath: path))
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("data error")
            print("data error2")
            print(error.localizedDescription)
            fatalError("data")
        }
    }
    
    func fetchAllExchanges() async throws -> [Exchange] {
        return try await fetch(Constants.MockPaths.allExchanges)
    }
    
    func fetchExchanges(by id: String) async throws -> [Exchange] {
        return try await fetch("\(id)exchanges")
    }
}
