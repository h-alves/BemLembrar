//
//  Brand.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 12/11/23.
//

import Foundation

struct Brand: Codable {
    var name: String
    var isSelected: Bool
    
    static var allBrands: [Brand] = [
        Brand(name: "Mary Kay", isSelected: false),
        Brand(name: "Avon", isSelected: false),
        Brand(name: "Natura", isSelected: false),
        Brand(name: "Boticário", isSelected: false)
    ]
    
    static var marykay = Brand(name: "Mary Kay", isSelected: false)
    static var avon = Brand(name: "Avon", isSelected: false)
    static var natura = Brand(name: "Natura", isSelected: false)
    static var boticario = Brand(name: "Boticário", isSelected: false)
}

extension Brand: Equatable {
    static func == (lhs: Brand, rhs: Brand) -> Bool {
        return lhs.name == rhs.name && lhs.isSelected == rhs.isSelected
    }
}
