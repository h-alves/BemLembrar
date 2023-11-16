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
        Strategy(name: "2+2+2", isSelected: false, timeInterval: 0, time: "2+2+2"),
        Strategy(name: "Mensal", isSelected: false, timeInterval: 30, time: "1 mês"),
        Strategy(name: "Semanal", isSelected: false, timeInterval: 7, time: "1 semana")
    ]
    
    static var none = Strategy(name: "", isSelected: true, timeInterval: 0, time: "")
    
    static var twoTwoTwo = Strategy(name: "2+2+2", isSelected: false, timeInterval: 0, time: "2+2+2")
    static var monthly = Strategy(name: "Mensal", isSelected: false, timeInterval: 30, time: "1 mês")
    static var weekly = Strategy(name: "Semanal", isSelected: false, timeInterval: 7, time: "1 semana")
}

extension Strategy: Equatable {
    static func == (lhs: Strategy, rhs: Strategy) -> Bool {
        return lhs.name == rhs.name && lhs.isSelected == rhs.isSelected && lhs.timeInterval == rhs.timeInterval && lhs.time == rhs.time
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
