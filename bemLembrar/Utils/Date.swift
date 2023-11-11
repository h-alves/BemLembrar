//
//  Date.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 11/11/23.
//

import Foundation

extension Date {
    
    func getMonthDay() -> DateComponents {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.month, .day], from: self)
        components.hour = 11
        
        print("data: \(calendar.date(from: components)!)")
        return components
    }
}
