//
//  String.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 11/11/23.
//

import Foundation

extension String {
    
    func removeClient() -> String {
        let name = self.replacingOccurrences(of: "cliente ?", with: "", options: [.caseInsensitive, .regularExpression])
        return name
    }
}
