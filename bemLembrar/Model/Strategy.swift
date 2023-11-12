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
        Strategy(name: "2+2+2", isSelected: false, timeInterval: 2),
        Strategy(name: "Anual", isSelected: false, timeInterval: 2),
        Strategy(name: "Mensal", isSelected: false, timeInterval: 2),
        Strategy(name: "Semanal", isSelected: false, timeInterval: 2),
        Strategy(name: "Apenas em datas comemorativas", isSelected: false, timeInterval: 2)
    ]
    
    static var twoTwoTwo = Strategy(name: "2+2+2", isSelected: false, timeInterval: 2)
    static var anual = Strategy(name: "Anual", isSelected: false, timeInterval: 2)
    static var monthly = Strategy(name: "Mensal", isSelected: false, timeInterval: 2)
    static var weekly = Strategy(name: "Semanal", isSelected: false, timeInterval: 2)
    static var comemorative = Strategy(name: "Apenas em datas comemorativas", isSelected: false, timeInterval: 2)
}

extension Strategy: Equatable {
    static func == (lhs: Strategy, rhs: Strategy) -> Bool {
        return lhs.name == rhs.name && lhs.isSelected == rhs.isSelected
    }
}
