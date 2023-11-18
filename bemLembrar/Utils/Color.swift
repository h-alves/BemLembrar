//
//  Color.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 16/11/23.
//

import Foundation
import SwiftUI

extension Color {
    
    func name() -> String {
        switch self {
        case .azul:
            return "azul"
        case .branco:
            return "branco"
        case .laranja:
            return "laranja"
        case .preto:
            return "preto"
        case .rosaEscuro:
            return "rosaEscuro"
        case .rosaMédio:
            return "rosaMedio"
        case .rosa:
            return "rosa"
        case .verdeClaro:
            return "verdeClaro"
        case .verdeEscuro:
            return "verdeEscuro"
        case .verdeOpaco:
            return "verdeOpaco"
        case .verde:
            return "verde"
        default:
            return self.description
        }
    }
}
