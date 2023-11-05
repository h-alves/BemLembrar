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
    let birthday: Date
    let preferences: Preferences
    
    static var test = Client(contactInfo: CNMutableContact().createTestContact(), fullName: CNMutableContact().createTestContact().givenName + " " + CNMutableContact().createTestContact().familyName, birthday: CNMutableContact().createTestContact().birthday!.createDate(), preferences: Preferences.none)
}

struct Preferences {
    let cheiro: Cheiro
    let pele: String
    let atendimento: String
    
    static var none = Preferences(cheiro: .amadeirado, pele: "", atendimento: "")
}

enum Cheiro: String {
    case doce = "doce"
    case floral = "floral"
    case citrico = "cítrico"
    case herbal = "herbal"
    case especiado = "especiado"
    case amadeirado = "amadeirado"
    case none = ""
}

enum Pele: String {
    case normal = "normal"
    case oleosa = "oleosa"
    case seca = "seca"
    case mista = "mista"
    case none = ""
}

enum Atendimento: String {
    case mensagem = "por mensagem"
    case ligacao = "por ligacao"
    case presencial = "presencial"
}
