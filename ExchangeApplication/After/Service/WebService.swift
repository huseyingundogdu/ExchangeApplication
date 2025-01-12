//
//  WebService.swift
//  ExchangeApplication
//
//  Created by Hüseyin Gündoğdu on 08/01/2025.
//

import Foundation

struct Webservice {
    
    private let baseURL = "http://localhost:8080/v1"
    private let token = "jsonwebtoken"
    
    private func getToken() -> String? {
        return UserDefaults.standard.string(forKey: token)
    }
    
    func request<T: Decodable>(
        endpoint: String,
        method: String,
        body: Data? = nil,
        responseType: T.Type
    ) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw WebServiceError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw WebServiceError.invalidResponse
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw WebServiceError.invalidData
        }
    }
    
    
    
    
    /*
    func login(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: Constants.Endpoints.login) else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(email: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
        }
        .resume()
    }
    
    func register(name: String, surname: String, email: String, password: String) {
        
    }
    
    func fetchAllCurrencies(token: String) async throws -> [Currency] {
        guard let url = URL(string: Constants.Endpoints.getAllCurrencies) else {
            throw WebServiceError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "jsonwebtoken")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([Currency].self, from: data)
     }
    
    func fetchCurrency(code: String, token: String) async throws -> Currency {
        guard let url = URL(string: Constants.Endpoints.getCurrencyByID + "/\(code)") else {
            throw WebServiceError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "jsonwebtoken")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(Currency.self, from: data)
    }
    
    func fetchCurrencyLast30Rate(code: String, token: String) async throws {}
    */
}
