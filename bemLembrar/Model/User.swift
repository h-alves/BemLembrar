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
    var strategy: Strategy
    var twoTwoTwo: Bool
    var comemorative: Bool
    
    static var test = User(name: "Teste", image: "", brands: Brand.allBrands, strategy: Strategy.none, twoTwoTwo: false, comemorative: false)
}

extension User: Codable {
    enum UserCodingKeys: String, CodingKey {
        case name, image, brands, strategy, twoTwoTwo, comemorative
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
        brands = try container.decode([Brand].self, forKey: .brands)
        strategy = try container.decode(Strategy.self, forKey: .strategy)
        twoTwoTwo = try container.decode(Bool.self, forKey: .twoTwoTwo)
        comemorative = try container.decode(Bool.self, forKey: .comemorative)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(image, forKey: .image)
        try container.encode(brands, forKey: .brands)
        try container.encode(strategy, forKey: .strategy)
        try container.encode(twoTwoTwo, forKey: .twoTwoTwo)
        try container.encode(comemorative, forKey: .comemorative)
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name && lhs.image == rhs.image && lhs.brands == rhs.brands && lhs.strategy == rhs.strategy && lhs.twoTwoTwo == rhs.twoTwoTwo && lhs.comemorative == rhs.comemorative
    }
}
