//
//  UserHeaderView.swift
//  ExchangeApplication
//
//  Created by Huseyin on 28/11/2024.
//

import SwiftUI

struct UserHeaderView: View {
    
    // FIXME: Temp. username.
    var user: User = User(id: "1", name: "Huso")
    
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "person")
                    .imageScale(.large)
                    .frame(width: 50, height: 50)
                    .background(.contentSecondary)
                    .clipShape(Circle())
            } // TODO: It can be just image, without button.
            
            VStack(alignment: .leading) {
                Text("Welcome Back")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Text(user.name) // TODO: User name will be here ViewModel's job.
                    .font(.headline)
                    .bold()
            }
            .foregroundStyle(.interactiveSecondary)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "gear")
                    .frame(width: 50, height: 50)
                    .background(.interactivePrimary)
                    .clipShape(Circle())
                    .foregroundStyle(.interactiveSecondary)
            }
        }
        
    }
}

#Preview {
    UserHeaderView()
        .background(Color.contentPrimary)
}
