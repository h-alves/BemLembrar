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
    
    func formatText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        return dateFormatter.string(from: self)
    }
    
    func createComponents(day: Int, month: Int) -> DateComponents {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day], from: self)
        components.day = day
        components.month = month
        
        return components
    }
    
    func todayAtEleven() -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.month,.day,.year], from: self)
        components.hour = 11
        
        return calendar.date(from: components)!
    }
}
