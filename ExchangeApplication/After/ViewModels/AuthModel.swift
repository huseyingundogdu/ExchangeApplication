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

struct RegisterRequest: Codable {
    let name: String
    let surname: String
    let email: String
    let password: String
}

struct RegisterResponse: Codable {
    let token: String
}

@MainActor
class AuthModel: ObservableObject {
    
    @Published var isAuthenticated = false
    @Published var user: User?
    
    @Published var isLoading = false
    
    // Error Handling
    @Published var informationMessage: String = ""
    @Published var informationMessageIsPresented = false
    @Published var hasError: Bool = false
    
    private let webservice = Webservice()
    
    func login(email: String, password: String) async {
        isLoading = true
        clearToken()
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        guard let body = try? JSONEncoder().encode(loginRequest) else {
            informationMessage = "Failed to encode login data"
            informationMessageIsPresented = true
            return
        }
        
        do {
            let response: LoginResponse = try await webservice.request(
                endpoint: "/auth/login",
                method: "POST",
                body: body,
                responseType: LoginResponse.self
            )!
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isLoading = false
                self.saveToken(response.token)
                self.isAuthenticated = true
                print(self.isAuthenticated)
            }
        } catch let error as WebServiceError {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isLoading = false
                self.informationMessage = error.description
                self.informationMessageIsPresented = true
            }
        } catch {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isLoading = false
                self.informationMessage = "Other Error login()"
                self.informationMessageIsPresented = true
            }
        }
    }
    
    func logout() {
        user = nil
        isAuthenticated = false
        isLoading = false
        informationMessageIsPresented = false
        hasError = false
        clearToken()
    }
    
    private func saveToken(_ token: String) {
        print("token saved: \(token)")
        UserDefaults.standard.setValue(token, forKey: "jsonwebtoken")
    }
    
    private func clearToken() {
//        UserDefaults.standard.removeObject(forKey: "jsonwebtoken")
        UserDefaults.resetStandardUserDefaults()
    }
    
    func register(name: String, surname: String, email: String, password: String) async {
        clearToken()
        isLoading = true
        
        let registerRequest = RegisterRequest(name: name, surname: surname, email: email, password: password)
        
        guard let body = try? JSONEncoder().encode(registerRequest) else {
            informationMessage = "Failed to encode register data"
            informationMessageIsPresented = true
            isLoading = false
            return
        }
        
        do {
            let response: RegisterResponse = try await webservice.request(
                endpoint: "/auth/register",
                method: "POST",
                body: body,
                responseType: RegisterResponse.self
            )!
            
            saveToken(response.token)
            print(response.token)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.informationMessage = "User created successfully."
                self.informationMessageIsPresented = true
            }
            
        } catch let error as WebServiceError {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isLoading = false
                self.informationMessage = error.description
                self.informationMessageIsPresented = true
            }
        } catch {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isLoading = false
                self.informationMessage = "Other Error login()"
                self.informationMessageIsPresented = true
            }
        }
    }
    
    func getUser() async {
        do {
            let response = try await webservice.request(
                endpoint: "/user",
                method: "GET",
                responseType: User.self
            )
            
            DispatchQueue.main.async {
                self.user = response
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
