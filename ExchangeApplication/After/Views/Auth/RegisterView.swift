//
//  RegisterView.swift
//  ExchangeApplication
//
//  Created by Hüseyin Gündoğdu on 12/01/2025.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authModel: AuthModel
    @EnvironmentObject var accountModel: AccountModel
    
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    Gradient(colors: [.interactivePrimary, .contentPrimary, .contentPrimary])
                )
                .ignoresSafeArea()
            VStack(spacing: 50) {
                
                Text("Register")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.semibold)
                
                VStack {
                    TextField("Name", text: $name)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 2)
                                .background(RoundedRectangle(cornerRadius: 12).fill(.contentPrimary))
                        )
                    TextField("Surname", text: $surname)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 2)
                                .background(RoundedRectangle(cornerRadius: 12).fill(.contentPrimary))
                        )
                    TextField("Email", text: $email)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 2)
                                .background(RoundedRectangle(cornerRadius: 12).fill(.contentPrimary))
                        )
                    SecureField("Password", text: $password)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 2)
                                .background(RoundedRectangle(cornerRadius: 12).fill(.contentPrimary))
                        )
                }
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                VStack {
                    Text("")
                }
                
                if !authModel.isLoading {
                    Button("Register") {
                        submitRegistrationForm()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 12).fill(isFormValid() ? .interactiveSecondary : .gray))
                    .foregroundStyle(.white)
                    .allowsHitTesting(isFormValid())
                } else {
                    ProgressView()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 12).fill(.interactiveSecondary))
                        .foregroundStyle(.white)
                }
            }
            .alert(isPresented: $authModel.informationMessageIsPresented) {
                Alert(
                    title: Text("Information"),
                    message: Text(authModel.informationMessage),
                    dismissButton: .destructive(Text("OK")) {
                        authModel.isLoading = false
//                        authModel.isAuthenticated = true
                        dismiss()
                    })
            }
            .padding()
        }
    }
    
    private func submitRegistrationForm() {
        Task {
            await authModel.register(name: name, surname: surname, email: email, password: password)
            
            await accountModel.createPLNAccount()
        }
    }
    
    private func isFormValid() -> Bool {
        if name != "", surname != "", email != "", password != "" {
            return true
        }
        return false
    }
}

#Preview {
    RegisterView()
        .environmentObject(AuthModel())
}
