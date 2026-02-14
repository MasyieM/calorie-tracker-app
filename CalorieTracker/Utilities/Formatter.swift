//
//  Formatter.swift
//  CalorieTracker
//
//  Created by Cik Nur Maasyitah on 14/02/2026.
//

import Foundation

enum AppFormatters {
    
    static let integer: NumberFormatter = { //further configures the NumberFormatter to fit the calorie text field needs
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.allowsFloats = false
        return formatter
    }()
    
}
