//
//  UserModel.swift
//  ExchangeApplication
//
//  Created by Huseyin on 29/12/2024.
//

import Foundation

@MainActor
class UserModel: ObservableObject {
    @Published var user: User = User(id: "1", name: "Huseyin")
}
