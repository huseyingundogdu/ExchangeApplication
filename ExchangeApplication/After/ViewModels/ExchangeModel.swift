//
//  ExchangeModel.swift
//  ExchangeApplication
//
//  Created by Huseyin on 30/12/2024.
//

import Foundation

struct ExchangeRequest: Codable {
    let plnAccount_id: String
    let otherAccount_id: String
    let amount: Double
    let operation: String
}


@MainActor
class ExchangeModel: ObservableObject {
    private let webservice = Webservice()
    
    @Published var exchanges: [Exchange] = []
    @Published var exchange: Exchange?
    
    @Published var resultMessage: String = ""
    @Published var hasInfo: Bool = false
    
    func postExchange(
        plnAccount_id: String,
        otherAccount_id: String,
        amount: Double,
        operation: String,
        completion: @escaping (WebServiceError?) -> Void
    ) async {
        
        let exchangeRequest = ExchangeRequest(plnAccount_id: plnAccount_id, otherAccount_id: otherAccount_id, amount: amount, operation: operation)
        
        guard let body = try? JSONEncoder().encode(exchangeRequest) else {
            resultMessage = "Invalid Input"
            hasInfo = true
            return
        }
        
        do {
            // Call request without expecting a response body
            _ = try await webservice.request(
                endpoint: "/exchange",
                method: "POST",
                body: body,
                responseType: Exchange.self
            )
            
            resultMessage = ""
            hasInfo = true
            completion(nil) // Success
        } catch let error as WebServiceError {
            completion(error) // Return WebServiceError
        } catch {
            print("")
        }
        
    }
    
    func postExchange2(
        plnAccount_id: String,
        otherAccount_id: String,
        amount: Double,
        operation: String
    ) async {
        
        let exchangeRequest = ExchangeRequest(plnAccount_id: plnAccount_id, otherAccount_id: otherAccount_id, amount: amount, operation: operation)
        
        guard let body = try? JSONEncoder().encode(exchangeRequest) else {
            print("body error")
            return
        }
        
        do {
            // Call request without expecting a response body
            _ = try await webservice.request(
                endpoint: "/exchange",
                method: "POST",
                body: body,
                responseType: Exchange.self
            )
            
            resultMessage = "Exchange operation maded successfully."
            hasInfo = true
        } catch {
            resultMessage = "Something went wrong. Try Again."
            hasInfo = true
        }
        
    }
}
