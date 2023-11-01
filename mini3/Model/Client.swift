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
    let preferences: Preferences
}

enum Preferences {
    case none, p1, p2, p3
}
