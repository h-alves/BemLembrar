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
    
    func updateList() {
        allClients = ClientDataSource.shared.allClients
    }
}
