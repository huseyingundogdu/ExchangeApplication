//
//  Login.swift
//  ExchangeApplication
//
//  Created by Huseyin on 01/01/2025.
//

import SwiftUI

struct Login: View {
    
    @EnvironmentObject private var authModel: AuthModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(
                        Gradient(colors: [.interactivePrimary, .contentPrimary, .contentPrimary])
                    )
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("chart")
                        .resizable()
                        .ignoresSafeArea()
                        .frame(maxWidth: 450, maxHeight: 200)
                        .aspectRatio(contentMode: .fill)
                }
                VStack(spacing: 50) {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    VStack(spacing: 20) {
                        TextField("Username", text: $email)
                            .textInputAutocapitalization(.never)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 2)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(.contentPrimary))
                            )
                            .foregroundColor(.white)
                        SecureField("Password", text: $password)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 2)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(.contentPrimary))
                            )
                            .foregroundColor(.white)
                    }
                    
                    VStack(spacing: 30) {
                        if !authModel.isLoading {
                            Button("Login") {
                                Task {
                                    await loginButton()
                                }
                            }
                            .font(.title3)
                            .frame(height: 30)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(.interactivePrimary)
                            .background(RoundedRectangle(cornerRadius: 12).fill(.interactiveSecondary))
                        } else {
                            ProgressView()
                                .frame(height: 30)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundStyle(.interactivePrimary)
                                .background(RoundedRectangle(cornerRadius: 12).fill(.interactiveSecondary))
                        }
                        
                        NavigationLink(destination: RegisterView()) {
                            Text("Register")
                                .foregroundStyle(.white)
                        }
                    }
                    Spacer()
                    
                }
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(.horizontal, 55)
                .alert(isPresented: $authModel.informationMessageIsPresented) {
                    Alert(
                        title: Text("Info"),
                        message: Text(authModel.informationMessage),
                        dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    private func loginButton() async {
        await authModel.login(email: email, password: password)
    }
}

#Preview {
    Login()
}
