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
            defaults.set(encoded, forKey: "userData")
            print("saved \(user)")
        }
    }
    
    func retrieve() {
        if let saved = defaults.object(forKey: "userData") as? Data {
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
}
