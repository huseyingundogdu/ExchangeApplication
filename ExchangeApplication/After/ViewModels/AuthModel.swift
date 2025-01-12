//
//  UserModel.swift
//  ExchangeApplication
//
//  Created by Huseyin on 29/12/2024.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String
}

@MainActor
class AuthModel: ObservableObject {
    
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    
    private let webservice = Webservice()
    
    func login(email: String, password: String) async {
        let loginRequest = LoginRequest(email: email, password: password)
        
        guard let body = try? JSONEncoder().encode(loginRequest) else {
            errorMessage = "Failed to encode login data"
            return
        }
        
        do {
            let response: LoginResponse = try await webservice.request(
                endpoint: "/auth/login",
                method: "POST",
                body: body,
                responseType: LoginResponse.self
            )
            
            saveToken(response.token)
            DispatchQueue.main.async {
                self.isAuthenticated = true
                print(self.isAuthenticated)
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func logout() {
        isAuthenticated = false
        clearToken()
    }
    
    private func saveToken(_ token: String) {
        print("token saved: \(token)")
        UserDefaults.standard.setValue(token, forKey: "jsonwebtoken")
    }
    
    private func clearToken() {
        UserDefaults.standard.removeObject(forKey: "jsonwebtoken")
    }
}
