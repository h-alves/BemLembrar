//
//  ClientDataSource.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 31/10/23.
//

import Foundation

class ClientDataSource: ObservableObject {
    
    static let shared = ClientDataSource()
    
    let defaults = UserDefaults.standard
    
    @Published var allClients = [Client]() {
        didSet {
            if oldValue != allClients {
                save()
            }
        }
    }
    
    private init(allClients: [Client] = [Client]()) {
        self.allClients = allClients
        retrieve()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(allClients) {
            defaults.set(encoded, forKey: "clientsSaved")
            print("saved \(allClients.count)")
        }
    }
    
    func retrieve() {
        if let saved = defaults.object(forKey: "clientsSaved") as? Data {
            print("saved")
            let decoder = JSONDecoder()
            
            do {
                let loaded = try decoder.decode([Client].self, from: saved)
                allClients = loaded
                print("retrieved \(loaded.count)")
            } catch {
                print(error)
            }
        }
    }
}
