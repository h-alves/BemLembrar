//
//  ClientViewModel.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 08/11/23.
//

import SwiftUI

class ClientViewModel: ObservableObject {
    @Published var client = Client.test
    
    @Published var isEditing = false
    
    @Published var address = ""
    @Published var birthday = Date()
    
    func updateClient(client: Client) {
        self.client = client
        
        self.address = client.address ?? ""
        self.birthday = client.birthday ?? Date()
        
        print(client)
    }
    
    func saveData() {
        if isEditing {
            if birthday.formatted(date: .numeric, time: .omitted) != Date().formatted(date: .numeric, time: .omitted) {
                client.birthday = birthday
            }
            
            client.address = address
            
            var allClients = ClientDataSource.shared.allClients
            let id = client.contactInfo.identifier
            
            for (index,originalClient) in allClients.enumerated() {
                if originalClient.contactInfo.identifier == id {
                    allClients[index].self = client
                }
            }
            
            ClientDataSource.shared.allClients = allClients
            
            print(ClientDataSource.shared.allClients)
        }
        
        self.isEditing.toggle()
    }
}
