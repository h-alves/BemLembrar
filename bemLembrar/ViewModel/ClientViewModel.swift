//
//  ClientViewModel.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 08/11/23.
//

import SwiftUI

class ClientViewModel: ObservableObject {
    @Published var client = Client.test
    
    @Published var addressIsEditing = false
    @Published var birthdayIsEditing = false
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
        
        self.shareText = "ooi querida \(client.fullName)🫶\ncomo você está? Está precisando de algum dos nossos produtos??🥰💐"
        if client.birthday == Date() {
            self.shareText = "Ooi \(client.fullName)! 🥳✨\nFeliz aniversário, te desejo muito amor, paz e sabedoria nessa nova primavera da sua vida! 🥰 💐 Obrigada pela confiança na minha consultoria e que sua luz nunca se apague"
        }
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
    
    // Funções de salvar edições
    
    func saveBirthday() {
        if birthdayIsEditing {
            if birthday.formatted(date: .numeric, time: .omitted) != Date().formatted(date: .numeric, time: .omitted) {
                client.birthday = birthday
            }
            
            changeOnDataSource()
        }
        
        setBirthdayNotification()
        
        self.birthdayIsEditing.toggle()
    }
    
    func saveAddress() {
        if addressIsEditing {
            client.address = address
            
            changeOnDataSource()
        }
        
        
        self.addressIsEditing.toggle()
    }
    
    func saveAnnotation() {
        if annotationIsEditing {
            client.annotation = annotation
            
            changeOnDataSource()
        }
        
        self.annotationIsEditing.toggle()
    }
    
    // Funções de entrar em contato
    
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
        if UserData.shared.user.twoTwoTwo {
            client.twoStage = client.twoStage.advance()
        }
        
        changeOnDataSource()
        setContactNotification()
    }
    
    // Funções de notificação
    
    func setBirthdayNotification() {
        NotificationManager.shared.cancelNotification(identifier: client.identifier, type: "birthday")
        
        if client.birthday != nil {
            NotificationManager.shared.scheduleDateNotification(identifier: client.identifier, fullName: client.fullName, date: client.birthday!.getMonthDay(), repeats: true)
        }
    }
    
    func setContactNotification() {
        NotificationManager.shared.cancelNotification(identifier: client.identifier, type: "lastContact")
        NotificationManager.shared.cancelNotification(identifier: client.identifier, type: "oneYear")
        
        if UserData.shared.user.twoTwoTwo {
            if client.twoStage == .day {
                NotificationManager.shared.schedule222Notification(identifier: client.identifier, fullName: client.fullName, time: "2 dias", interval: getInterval(value: 2), repeats: false)
                print(client.twoStage)
            } else if client.twoStage == .week {
                NotificationManager.shared.schedule222Notification(identifier: client.identifier, fullName: client.fullName, time: "2 semanas", interval: getInterval(value: 14), repeats: false)
            } else if client.twoStage == .month {
                NotificationManager.shared.schedule222Notification(identifier: client.identifier, fullName: client.fullName, time: "2 meses", interval: getInterval(value: 60), repeats: false)
            }
        } else if UserData.shared.user.strategy != .none {
            NotificationManager.shared.scheduleTimeIntervalNotification(identifier: client.identifier, fullName: client.fullName, time: UserData.shared.user.strategy.time, interval: getInterval(value: UserData.shared.user.strategy.timeInterval), repeats: false)
        }
        
        NotificationManager.shared.scheduleYearNotification(identifier: client.identifier, fullName: client.fullName, repeats: false)
    }
    
    func getInterval(value: Int) -> TimeInterval {
        let calendar = Calendar.current
        
        var futureDate = calendar.date(byAdding: .day, value: value, to: Date())
        var components = calendar.dateComponents([.month,.day,.year], from: futureDate!)
        components.hour = 11
        
        futureDate = calendar.date(from: components)
        
        return futureDate!.timeIntervalSinceNow
    }
}
