//
//  User.swift
//  ExchangeApplication
//
//  Created by Huseyin on 28/12/2024.
//

import Foundation


struct User: Codable {
    let name: String
    let surname: String
    let email: String
    let password: String
    let date: String?
}
