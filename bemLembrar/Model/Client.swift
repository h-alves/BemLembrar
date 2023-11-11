//
//  Client.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 31/10/23.
//

import Foundation
import Contacts

struct Client {
    var contactInfo: CNContact
    let identifier: String
    let fullName: String
    var birthday: Date?
    var address: String?
    var preferences: Preferences
    var annotation: String
    
    static var test = Client(contactInfo: CNMutableContact().createTestContact(), identifier: "A", fullName: CNMutableContact().createTestContact().givenName + " " + CNMutableContact().createTestContact().familyName, birthday: CNMutableContact().createTestContact().birthday!.createDate(), address: "Rua X, 1226", preferences: Preferences.test, annotation: "")
}

extension Client: Codable {
    enum CodingKeys: String, CodingKey {
        case identifier, fullName, birthday, address, preferences, annotation
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        fullName = try container.decode(String.self, forKey: .fullName)
        if let seconds = try container.decodeIfPresent(TimeInterval.self, forKey: .birthday) {
            birthday = Date(timeIntervalSince1970: seconds)
        } else {
            birthday = nil
        }
        address = try container.decodeIfPresent(String.self, forKey: .address)
        preferences = try container.decode(Preferences.self, forKey: .preferences)
        annotation = try container.decode(String.self, forKey: .annotation)
        contactInfo = CNContact()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(fullName, forKey: .fullName)
        try container.encode(birthday?.timeIntervalSince1970, forKey: .birthday)
        try container.encode(address, forKey: .address)
        try container.encode(preferences, forKey: .preferences)
        try container.encode(annotation, forKey: .annotation)
    }
}

extension Client: Equatable {
    static func == (lhs: Client, rhs: Client) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.fullName == rhs.fullName && lhs.birthday == rhs.birthday && lhs.address == rhs.address && lhs.annotation == rhs.annotation && lhs.preferences == rhs.preferences
    }
}
