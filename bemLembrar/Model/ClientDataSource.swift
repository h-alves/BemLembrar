//
//  ClientDataSource.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 31/10/23.
//

import Foundation

class ClientDataSource: ObservableObject {
    static let shared = ClientDataSource()
    
    @Published var allClients = [Client]()
    
    private init(allClients: [Client] = [Client]()) {
        self.allClients = allClients
        self.allClients.append(Client.test)
    }
}
