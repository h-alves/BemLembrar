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
    
    static var allStrategies: [Strategy] = [
        Strategy(name: "2+2+2", isSelected: false),
        Strategy(name: "Anual", isSelected: false),
        Strategy(name: "Mensal", isSelected: false),
        Strategy(name: "Semanal", isSelected: false),
        Strategy(name: "Apenas em datas comemorativas", isSelected: false)
    ]
    
    static var twoTwoTwo = Strategy(name: "2+2+2", isSelected: false)
    static var anual = Strategy(name: "Anual", isSelected: false)
    static var monthly = Strategy(name: "Mensal", isSelected: false)
    static var weekly = Strategy(name: "Semanal", isSelected: false)
    static var comemorative = Strategy(name: "Apenas em datas comemorativas", isSelected: false)
}

extension Strategy: Equatable {
    static func == (lhs: Strategy, rhs: Strategy) -> Bool {
        return lhs.name == rhs.name && lhs.isSelected == rhs.isSelected
    }
}
