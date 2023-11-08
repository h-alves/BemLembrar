//
//  Client.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 31/10/23.
//

import Foundation
import Contacts

struct Client {
    let contactInfo: CNContact
    let fullName: String
    let birthday: Date?
    let address: String?
    var preferences: Preferences
    
    static var test = Client(contactInfo: CNMutableContact().createTestContact(), fullName: CNMutableContact().createTestContact().givenName + " " + CNMutableContact().createTestContact().familyName, birthday: CNMutableContact().createTestContact().birthday!.createDate(), address: "Rua X, 1226", preferences: Preferences.test)
}
