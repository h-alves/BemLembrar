//
//  InitialContact.swift
//  mini3
//
//  Created by Henrique Semmer on 30/10/23.
//

import Foundation
import Contacts

struct InitialContact: Equatable {
    var contactInfo: CNContact
    var isSelected: Bool
    
    static var teste = InitialContact(contactInfo: CNMutableContact().createTestContact(), isSelected: false)
}
