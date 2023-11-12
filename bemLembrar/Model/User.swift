//
//  User.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 12/11/23.
//

import Foundation

struct User {
    var name: String
    var image: String
    var brands: [Brand]
    var strategy: [Strategy]
    
    static var test = User(name: "Teste", image: "", brands: [.avon, .marykay], strategy: [.monthly])
}

extension User: Codable {
    enum UserCodingKeys: String, CodingKey {
        case name, image, brands, strategy
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        brands = try container.decode([Brand].self, forKey: .brands)
        strategy = try container.decode([Strategy].self, forKey: .strategy)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
        try container.encode(brands, forKey: .brands)
        try container.encode(strategy, forKey: .strategy)
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name && lhs.image == rhs.image && lhs.brands == rhs.brands && lhs.strategy == rhs.strategy
    }
}
