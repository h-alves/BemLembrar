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
    
    @Published var lastContact = Date.distantPast
    
    @Published var shareText = ""
    
    func updateClient(client: Client) {
//        print(client)
        
        self.client = client
        
        self.address = client.address
        self.birthday = client.birthday ?? Date()
        self.annotation = client.annotation
        self.lastContact = client.lastContact ?? Date.distantPast
        
        self.shareText = "Olá \(client.fullName), como você está? Espero que bem! Vim aqui falar contigo por que blá blá blá"
    }
    
    func saveInfo() {
        if infoIsEditing {
            if birthday.formatted(date: .numeric, time: .omitted) != Date().formatted(date: .numeric, time: .omitted) {
                client.birthday = birthday
            }
            
            client.address = address
            
            changeOnDataSource()
        }
        
        recreateNotifications()
        
        self.infoIsEditing.toggle()
    }
    
    func saveAnnotation() {
        if annotationIsEditing {
            client.annotation = annotation
            
            changeOnDataSource()
        }
        
        self.annotationIsEditing.toggle()
    }
    
    func recreateNotifications() {
        NotificationManager.shared.cancelDateNotification(identifier: client.identifier, type: "birthday")
        
        if client.birthday != nil {
            NotificationManager.shared.scheduleDateNotification(identifier: client.identifier, type: "birthday", fullName: client.fullName, date: client.birthday!.getMonthDay(), repeats: true)
        }
    }
    
    func callClient() {
        let telephone = "tel://"
        let formattedString = telephone + client.number
        guard let url = URL(string: formattedString) else { return }
        UIApplication.shared.open(url)
        
        registerContact()
    }
    
    func shareMessage() {
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        UIApplication.shared.currentUIWindow()?.rootViewController?.present(activityVC, animated: true, completion: nil)
        
        registerContact()
    }
    
    func registerContact() {
        client.lastContact = Date()
        lastContact = Date()
        
        changeOnDataSource()
    }
    
    func changeOnDataSource() {
        let id = client.identifier
        
        for (index,originalClient) in ClientDataSource.shared.allClients.enumerated() {
            if originalClient.identifier == id {
                ClientDataSource.shared.allClients[index].self = client
//                print(ClientDataSource.shared.allClients[index].self)
            }
        }
    }
}
