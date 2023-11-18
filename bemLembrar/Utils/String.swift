//
//  String.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 11/11/23.
//

import Foundation

extension String {
    
    func removeClient() -> String {
        var name = self.replacingOccurrences(of: "cliente", with: "", options: [.caseInsensitive, .regularExpression])
        name = self.replacingOccurrences(of: " cliente", with: "", options: [.caseInsensitive, .regularExpression])
        name = self.replacingOccurrences(of: " cliente ", with: "", options: [.caseInsensitive, .regularExpression])
        name = self.replacingOccurrences(of: "cliente ", with: "", options: [.caseInsensitive, .regularExpression])
        return name
    }
    
    func removeFamilyName() -> String {
        var string = self
        
        if let spaceRange = string.range(of: " ") {
            string.removeSubrange(spaceRange.lowerBound..<string.endIndex)
        }
        
        return string
    }
}
