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
    var timeInterval: TimeInterval
    
    static var allStrategies: [Strategy] = [
        Strategy(name: "Há cada 2 meses", isSelected: false, timeInterval: getInterval(value: 60)),
        Strategy(name: "Mensal", isSelected: false, timeInterval: getInterval(value: 30)),
        Strategy(name: "Quinzenal", isSelected: false, timeInterval: getInterval(value: 14)),
        Strategy(name: "Semanal", isSelected: false, timeInterval: getInterval(value: 7))
    ]
    
    static var none = Strategy(name: "", isSelected: true, timeInterval: 2)
    
    static var twoTwoTwo = Strategy(name: "2+2+2", isSelected: false, timeInterval: 0)
    static var comemorative = Strategy(name: "Apenas em datas comemorativas", isSelected: false, timeInterval: 0)
    
    static var twoMonth = Strategy(name: "Há cada 2 meses", isSelected: false, timeInterval: getInterval(value: 60))
    static var monthly = Strategy(name: "Mensal", isSelected: false, timeInterval: 2)
    static var twoWeek = Strategy(name: "Quinzenal", isSelected: false, timeInterval: getInterval(value: 14))
    static var weekly = Strategy(name: "Semanal", isSelected: false, timeInterval: 2)
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
