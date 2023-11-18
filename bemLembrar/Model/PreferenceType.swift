//
//  PreferenceType.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 05/11/23.
//

import Foundation

enum PreferenceType {
    case smell, skin, service
}

extension PreferenceType {
    
    func getName() -> String {
        switch self {
        case .smell:
            return "fragrância"
        case .skin:
            return "pele"
        case .service:
            return "atendimento por"
        }
    }
}
