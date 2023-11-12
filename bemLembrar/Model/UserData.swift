//
//  UserData.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 12/11/23.
//

import Foundation

class UserData: ObservableObject {
    
    static let shared = UserData()
    
    let defaults = UserDefaults.standard
    
    @Published var user: User {
        didSet {
            if oldValue != user {
                save()
            }
        }
    }
    
    private init(user: User = User.test) {
        self.user = user
        retrieve()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            defaults.set(encoded, forKey: "userSaved")
            print("saved \(user)")
        }
    }
    
    func retrieve() {
        if let saved = defaults.object(forKey: "userSaved") as? Data {
            print("saved")
            let decoder = JSONDecoder()
            
            do {
                let loaded = try decoder.decode(User.self, from: saved)
                user = loaded
                print("retrieved \(user)")
            } catch {
                print(error)
            }
        }
    }
    
    func setInfo(name: String, image: String, brands: [Brand], strategy: [Strategy]) {
        user.name = name
        user.image = image
        user.brands = brands
        user.strategy = strategy
    }
}
