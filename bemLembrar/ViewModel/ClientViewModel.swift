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
            
            let id = client.identifier
            
            for (index,originalClient) in ClientDataSource.shared.allClients.enumerated() {
                if originalClient.identifier == id {
                    ClientDataSource.shared.allClients[index].self = client
                }
            }
            
            print(ClientDataSource.shared.allClients)
        }
        
        recreateNotifications()
        
        self.infoIsEditing.toggle()
    }
    
    func saveAnnotation() {
        if annotationIsEditing {
            client.annotation = annotation
            
            let id = client.identifier
            
            for (index,originalClient) in ClientDataSource.shared.allClients.enumerated() {
                if originalClient.identifier == id {
                    ClientDataSource.shared.allClients[index].self = client
                }
            }
        }
        
        self.annotationIsEditing.toggle()
    }
    
    func recreateNotifications() {
        NotificationManager.shared.cancelAllNotifications()
        
        for i in ClientDataSource.shared.allClients {
            if i.birthday != nil {
                NotificationManager.shared.scheduleNotification(fullName: i.fullName, date: i.birthday!.getMonthDay(), repeats: true)
            }
        }
    }
}
