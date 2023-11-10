//
//  ClientViewModel.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 08/11/23.
//

import SwiftUI

class ClientViewModel: ObservableObject {
    @Published var client = Client.test
    
    @Published var infoIsEditing = false
    @Published var annotationIsEditing = false
    
    @Published var address = ""
    @Published var birthday = Date()
    
    @Published var annotation = ""
    
    func updateClient(client: Client) {
        self.client = client
        
        self.address = client.address ?? ""
        self.birthday = client.birthday ?? Date()
        self.annotation = client.annotation
    }
    
    func saveInfo() {
        if infoIsEditing {
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
        
        self.infoIsEditing.toggle()
    }
    
    func saveAnnotation() {
        if annotationIsEditing {
            client.annotation = annotation
            
            let id = client.contactInfo.identifier
            
            for (index,originalClient) in ClientDataSource.shared.allClients.enumerated() {
                if originalClient.contactInfo.identifier == id {
                    ClientDataSource.shared.allClients[index].self = client
                }
            }
        }
        
        self.annotationIsEditing.toggle()
    }
}
