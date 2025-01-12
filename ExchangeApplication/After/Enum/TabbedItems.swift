//
//  TabbedItems.swift
//  ExchangeApplication
//
//  Created by Huseyin on 29/12/2024.
//

import Foundation

enum TabbedItems: Int, CaseIterable {
    case home = 0
    case history
    case settings
    
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .history:
            return "History"
        case .settings:
            return "Settings"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "home"
        case .history:
            return "list.bullet"
        case .settings:
            return "gearshape"
        }
    }
}
