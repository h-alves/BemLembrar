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
    var birthday: Date?
    var address: String?
    var preferences: Preferences
    var annotation: String
    
    static var test = Client(contactInfo: CNMutableContact().createTestContact(), fullName: CNMutableContact().createTestContact().givenName + " " + CNMutableContact().createTestContact().familyName, birthday: CNMutableContact().createTestContact().birthday!.createDate(), address: "Rua X, 1226", preferences: Preferences.test, annotation: "")
}
