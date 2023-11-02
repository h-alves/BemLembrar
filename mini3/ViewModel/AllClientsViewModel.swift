//
//  AllClientsViewModel.swift
//  mini3
//
//  Created by Henrique Semmer on 02/11/23.
//

import Foundation
import Contacts

class AllClientsViewModel: ObservableObject {
    @Published var allClients = [Client]()
    
    @Published var searchText: String = ""
    
    func testContact() {
        let newClient = Client(contactInfo: CNMutableContact().createTestContact(), preferences: Preferences.none)
        ClientDataSource.shared.allClients.append(newClient)
        
        allClients = ClientDataSource.shared.allClients
        
        print(allClients)
    }
}
