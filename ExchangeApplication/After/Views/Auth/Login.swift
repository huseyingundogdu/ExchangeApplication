//
//  Login.swift
//  ExchangeApplication
//
//  Created by Huseyin on 01/01/2025.
//

import SwiftUI

struct Login: View {
    
    @EnvironmentObject private var authModel: AuthModel
    
    @State private var email: String = "hg@gmail.com"
    @State private var password: String = "123123"
    
    var body: some View {
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
                Text("---   Zlotify   ---")
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
                    TextField("Password", text: $password)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 2)
                                .background(RoundedRectangle(cornerRadius: 12).fill(.contentPrimary))
                        )
                        .foregroundColor(.white)
                }
                
                VStack(spacing: 30) {
                    Button("Login") {
                        //userModel.login(email: email, password: password)
                        Task {
                            await authModel.login(email: email, password: password)
                        }
                    }
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(.interactivePrimary)
                    .background(RoundedRectangle(cornerRadius: 12).fill(.interactiveSecondary))
                    
                    Button("Register") {
                        UserDefaults.standard.removeObject(forKey: "jsonwebtoken")
                    }
                    .font(.callout)
                    .foregroundStyle(.interactiveSecondary)
                }
                Spacer()
                
            }
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(.horizontal, 55)
            
            
            

        }
    }
}

#Preview {
    Login()
}
