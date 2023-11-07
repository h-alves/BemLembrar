//
//  DateComponents.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import Foundation

extension DateComponents {
    
    func createDate() -> Date {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: self)!
    }
}
