//
//  AllClientsViewModel.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 02/11/23.
//

import Foundation
import Contacts
import Combine

class AllClientsViewModel: ObservableObject {
    @Published var allClients = [Client]()
    @Published var allClientsSearch = [Client]()
    
    @Published var client = Client.test
    
    @Published var searchText: String = ""
    @Published var isDisabled = true
    
    @Published var isEditing = false
    @Published var isPresented = false
    
    var bag = Set<AnyCancellable>()
    
    func subscribe() {
        ClientDataSource.shared.$allClients.sink { clients in
            self.updateList()
        }.store(in: &bag)
    }
    
    func cancelSubscription() {
        for item in bag {
            item.cancel()
        }
        bag.removeAll()
    }
    
    func updateList() {
        allClients = ClientDataSource.shared.allClients
        allClientsSearch = ClientDataSource.shared.allClients
        
        if searchText != "" {
            allClientsSearch = allClients.filter{ c in
                let textFormat = searchText.lowercased()
                
                return c.fullName.lowercased().contains(textFormat)
            }
        } else {
            allClientsSearch = allClients
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
    
    func delete() {
        ClientDataSource.shared.allClients.removeAll { c in
            c.identifier == client.identifier
        }
        
        updateList()
        
        recreateNotifications()
        
        if allClients.isEmpty {
            isEditing.toggle()
            ClientDataSource.shared.allClients = allClients
        }
    }
    
    func recreateNotifications() {
        NotificationManager.shared.cancelNotification(identifier: client.identifier, type: "birthday")
    }
}
