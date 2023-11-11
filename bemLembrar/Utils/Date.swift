//
//  Date.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 11/11/23.
//

import Foundation

extension Date {
    
    func getMonthDay() -> TimeInterval {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.month, .day], from: self)
        
        // Obter o ano atual
        let currentYear = calendar.component(.year, from: Date())
        
        components.year = currentYear
        
        let newDate = calendar.date(from: components)
        
        if Date() > newDate! {
            components.year = currentYear + 1
            print("ano q vem: \(calendar.date(from: components)!)")
            return calendar.date(from: components)!.timeIntervalSinceNow
        }
        
        print("esse ano: \(newDate!)")
        return newDate!.timeIntervalSinceNow
    }
}
