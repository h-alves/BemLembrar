//
//  AllClientsViewModel.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 02/11/23.
//

import Foundation
import Contacts

class AllClientsViewModel: ObservableObject {
    @Published var allClients = [Client]()
    
    @Published var searchText: String = ""
    
    @Published var isEditing = false
    
    func updateList() {
        allClients = ClientDataSource.shared.allClients
        
        if searchText != "" {
            allClients = allClients.filter{ c in
                let textFormat = searchText.lowercased()
                
                return c.fullName.lowercased().contains(textFormat)
            }
        }
    }
    
    func editList() {
        if isEditing {
            ClientDataSource.shared.allClients = allClients
        }
        
        if !allClients.isEmpty {
            isEditing.toggle()
        }
    }
    
    func delete(client: Client) {
        allClients.removeAll { c in
            c.contactInfo.identifier == client.contactInfo.identifier
        }
        
        if allClients.isEmpty {
            isEditing.toggle()
        }
    }
}
