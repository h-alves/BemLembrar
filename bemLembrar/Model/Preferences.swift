//
//  Preferences.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 08/11/23.
//

import Foundation

struct Preferences: Codable {
    var cheiro: [Cheiro]
    var pele: Pele
    var atendimento: Atendimento
    
    static var test = Preferences(cheiro: [.amadeirado], pele: .oleosa, atendimento: .mensagem)
    static var none = Preferences(cheiro: [], pele: .normal, atendimento: .none)
}

extension Preferences: Equatable {
}

enum Cheiro: String, CaseIterable, Codable {
    case none = ""
    
    case doce = "doce"
    case amadeirado = "amadeirado"
    case floral = "floral"
    case citrico = "cítrico"
    case herbal = "herbal"
    case especiado = "especiado"
    
    static var allCases: [Cheiro] {
        return [.doce, .amadeirado, .floral, .citrico, .herbal, .especiado]
    }
}

enum Pele: String, CaseIterable, Codable {
    case normal = "normal"
    
    case oleosa = "oleosa"
    case seca = "seca"
    case mista = "mista"
    
    static var allCases: [Pele] {
        return [.oleosa, .seca, .mista]
    }
}

enum Atendimento: String, CaseIterable, Codable {
    case none = ""
    
    case mensagem = "mensagem"
    case ligacao = "ligacao"
    case presencial = "presencial"
    
    static var allCases: [Atendimento] {
        return [.mensagem, .ligacao, .presencial]
    }
}
