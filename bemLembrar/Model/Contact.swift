//
//  Contact.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 30/10/23.
//

import Foundation
import Contacts

struct Contact: Equatable {
    var contactInfo: CNContact
    var isSelected: Bool
    
    static var test = Contact(contactInfo: CNMutableContact().createTestContact(), isSelected: false)
}
