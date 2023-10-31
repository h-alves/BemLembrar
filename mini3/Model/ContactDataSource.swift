//
//  ContactDataSource.swift
//  mini3
//
//  Created by Henrique Semmer on 31/10/23.
//

import Foundation

class ContactDataSource: ObservableObject {
    static let shared = ContactDataSource()
    
    @Published var allClients = [Contact]()
    
    private init(allClients: [Contact] = [Contact]()) {
        self.allClients = allClients
    }
}
