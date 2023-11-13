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
    let number: String
    let fullName: String
    var birthday: Date?
    var address: String
    var preferences: Preferences
    var annotation: String
    var lastContact: Date?
    var twoStage: twoStageType
    
    static var test = Client(contactInfo: CNMutableContact().createTestContact(), identifier: "A", number: CNMutableContact().createTestContact().phoneNumbers[0].value.stringValue, fullName: CNMutableContact().createTestContact().givenName + " " + CNMutableContact().createTestContact().familyName, birthday: CNMutableContact().createTestContact().birthday!.createDate(), address: "Rua X, 1226", preferences: Preferences.test, annotation: "", twoStage: .none)
}

extension Client: Codable {
    enum ClientCodingKeys: String, CodingKey {
        case identifier, number, fullName, birthday, address, preferences, annotation, lastContact, twoStage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ClientCodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        number = try container.decode(String.self, forKey: .number)
        fullName = try container.decode(String.self, forKey: .fullName)
        if let secondsBirthday = try container.decodeIfPresent(TimeInterval.self, forKey: .birthday) {
            birthday = Date(timeIntervalSince1970: secondsBirthday)
        } else {
            birthday = nil
        }
        address = try container.decode(String.self, forKey: .address)
        preferences = try container.decode(Preferences.self, forKey: .preferences)
        annotation = try container.decode(String.self, forKey: .annotation)
        if let secondsContact = try container.decodeIfPresent(TimeInterval.self, forKey: .lastContact) {
            lastContact = Date(timeIntervalSince1970: secondsContact)
        } else {
            lastContact = nil
        }
        twoStage = try container.decode(twoStageType.self, forKey: .twoStage)
        contactInfo = CNContact()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ClientCodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(number, forKey: .number)
        try container.encode(fullName, forKey: .fullName)
        try container.encode(birthday?.timeIntervalSince1970, forKey: .birthday)
        try container.encode(address, forKey: .address)
        try container.encode(preferences, forKey: .preferences)
        try container.encode(annotation, forKey: .annotation)
        try container.encode(lastContact?.timeIntervalSince1970, forKey: .lastContact)
        try container.encode(twoStage, forKey: .twoStage)
    }
}

extension Client: Equatable {
    static func == (lhs: Client, rhs: Client) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.number == rhs.number && lhs.fullName == rhs.fullName && lhs.birthday == rhs.birthday && lhs.address == rhs.address && lhs.annotation == rhs.annotation && lhs.preferences == rhs.preferences && lhs.lastContact == rhs.lastContact
    }
}

enum twoStageType: Codable {
    case none, day, week, month
}

extension twoStageType {
    
    func advance() -> twoStageType {
        if self == .day {
            return .week
        } else if self == .week {
            return .month
        } else if self == .month {
            return .none
        } else {
            return .day
        }
    }
}
