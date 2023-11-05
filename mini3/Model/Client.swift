//
//  Client.swift
//  mini3
//
//  Created by Henrique Semmer on 31/10/23.
//

import Foundation
import Contacts

struct Client {
    let contactInfo: CNContact
    let fullName: String
    let birthday: Date?
    let preferences: Preferences
    
    static var test = Client(contactInfo: CNMutableContact().createTestContact(), fullName: CNMutableContact().createTestContact().givenName + " " + CNMutableContact().createTestContact().familyName, birthday: CNMutableContact().createTestContact().birthday!.createDate(), preferences: Preferences.test)
}

struct Preferences {
    let cheiro: [Cheiro]
    let pele: [Pele]
    let atendimento: [Atendimento]
    
    static var test = Preferences(cheiro: [.amadeirado], pele: [.oleosa], atendimento: [.mensagem])
    static var none = Preferences(cheiro: [], pele: [], atendimento: [])
}

enum Cheiro: String, CaseIterable {
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

enum Pele: String, CaseIterable {
    case normal = "normal"
    
    case oleosa = "oleosa"
    case seca = "seca"
    case mista = "mista"
    
    static var allCases: [Pele] {
        return [.oleosa, .seca, .mista]
    }
}

enum Atendimento: String, CaseIterable {
    case none = ""
    
    case mensagem = "por mensagem"
    case ligacao = "por ligacao"
    case presencial = "presencial"
    
    static var allCases: [Atendimento] {
        return [.mensagem, .ligacao, .presencial]
    }
}
