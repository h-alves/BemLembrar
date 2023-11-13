//
//  Strategy.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 12/11/23.
//

import Foundation

struct Strategy: Codable {
    let name: String
    var isSelected: Bool
    var timeInterval: Int
    var time: String
    
    static var allStrategies: [Strategy] = [
        Strategy(name: "Há cada 2 meses", isSelected: false, timeInterval: 61, time: "2 meses"),
        Strategy(name: "Mensal", isSelected: false, timeInterval: 30, time: "1 mês"),
        Strategy(name: "Quinzenal", isSelected: false, timeInterval: 14, time: "2 semanas"),
        Strategy(name: "Semanal", isSelected: false, timeInterval: 7, time: "1 semana")
    ]
    
    static var none = Strategy(name: "", isSelected: true, timeInterval: 0, time: "")
    
    static var twoMonth = Strategy(name: "Há cada 2 meses", isSelected: false, timeInterval: 61, time: "2 meses")
    static var monthly = Strategy(name: "Mensal", isSelected: false, timeInterval: 30, time: "1 mês")
    static var twoWeek = Strategy(name: "Quinzenal", isSelected: false, timeInterval: 14, time: "2 semanas")
    static var weekly = Strategy(name: "Semanal", isSelected: false, timeInterval: 7, time: "1 semana")
}

extension Strategy: Equatable {
    static func == (lhs: Strategy, rhs: Strategy) -> Bool {
        return lhs.name == rhs.name && lhs.isSelected == rhs.isSelected
    }
}

func getInterval(value: Int) -> TimeInterval {
    let calendar = Calendar.current
    
    var futureDate = calendar.date(byAdding: .day, value: value, to: Date())
    var components = calendar.dateComponents([.month,.day,.year], from: futureDate!)
    components.hour = 11
    
    futureDate = calendar.date(from: components)
    
    return futureDate!.timeIntervalSinceNow
}

extension [Strategy] {
    
    func refactor() -> [Strategy] {
        var allStrategies = self
        
        for (index, strategy) in allStrategies.enumerated() {
            if strategy.name == UserData.shared.user.strategy.name {
                allStrategies[index].isSelected = true
            }
        }
        
        return allStrategies
    }
}
