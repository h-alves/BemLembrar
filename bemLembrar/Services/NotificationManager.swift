//
//  NotificationManager.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 11/11/23.
//

import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    
    static let shared = NotificationManager()
    
    @Published var notificationResponse: UNNotificationResponse?
    
    private init() {}
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permissão concedida")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // Funções de marcar notificação
    
    func scheduleDateNotification(identifier: String, fullName: String, date: DateComponents, repeats: Bool) {
        let content = UNMutableNotificationContent()
        content.title = "Hoje é o aniversário de \(fullName.capitalized)!"
        content.body = "Alegre seu dia e mande uma mensagem desejando os parabéns! 🥳✨"
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: repeats)
        let id = identifier + "birthday"
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Houve um erro ao agendar a notificação de data: \(error)")
            } else {
                print("Notificação de data agendada com sucesso!")
            }
        }
        
        print("Tentativa de agendar uma notificação de data")
    }
    
    func scheduleTimeIntervalNotification(identifier: String, fullName: String, time: String, interval: TimeInterval, repeats: Bool) {
        let content = UNMutableNotificationContent()
        content.title = "\(fullName.capitalized) 💐❣️"
        content.body = "Já fazem \(time) do último contato com \(fullName.capitalized), vamos mandar uma mensagem?🥰"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: repeats)
        let id = identifier + "lastContact"
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Houve um erro ao agendar a notificação de intervalo: \(error)")
            } else {
                print("Notificação de intervalo agendada com sucesso!")
            }
        }
        
        print("Tentativa de agendar uma notificação de intervalo")
        
//        let calendar = Calendar.current
//        print(time)
//        print(calendar.date(byAdding: .second, value: Int(interval), to: Date()))
    }
    
    func scheduleYearNotification(identifier: String, fullName: String, repeats: Bool) {
        let content = UNMutableNotificationContent()
        content.title = "\(fullName.capitalized)"
        content.body = "Que saudades!😥 Não falamos com \(fullName.capitalized) há um ano! O que acha de dar uma ligadinha?😘❤️"
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([.month,.day], from: Date())
        components.hour = 11
        components.year = calendar.dateComponents([.year], from: Date()).year! + 1
        
        let futureDate = calendar.date(from: components)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: futureDate!.timeIntervalSinceNow, repeats: repeats)
        let id = identifier + "oneYear"
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Houve um erro ao agendar a notificação de intervalo: \(error)")
            } else {
                print("Notificação de intervalo agendada com sucesso!")
            }
        }
        
        print("Tentativa de agendar uma notificação de intervalo")
        
//        let calendar = Calendar.current
//        print(time)
//        print(calendar.date(byAdding: .second, value: Int(interval), to: Date()))
    }
    
    func schedule222Notification(identifier: String, fullName: String, time: String, interval: TimeInterval, repeats: Bool) {
        let content = UNMutableNotificationContent()
        content.title = "2+2+2 é a chave"
        content.body = "Agora é o momento ideal para se reconectar! Vamos bater um papo com \(fullName)? 🥰❣️️"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: repeats)
        let id = identifier + "lastContact"
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Houve um erro ao agendar a notificação de intervalo: \(error)")
            } else {
                print("Notificação de intervalo agendada com sucesso!")
            }
        }
        
        print("Tentativa de agendar uma notificação de intervalo")
        
//        let calendar = Calendar.current
//        print(time)
//        print(calendar.date(byAdding: .second, value: Int(interval), to: Date()))
    }
    
    func scheduleComemorativeNotification(identifier: String, date: DateComponents, name: String) {
        let content = UNMutableNotificationContent()
        content.title = "\(name) está batendo na porta!"
        content.body = "Será que seus clientes já garantiram seus presentes?😯 Vamos entrar em contato?🥰❣️"
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Houve um erro ao agendar a notificação de data comemorativa: \(error)")
            } else {
                print("Notificação de data comemorativa agendada com sucesso!")
            }
        }
        
        print("Tentativa de agendar uma notificação de data comemorativa")
    }
    
    // Funções de cancelar notificação

    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func cancelNotification(identifier: String, type: String) {
        let id = identifier + type
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        print("Notificação de data cancelada com sucesso!")
    }
    
    func cancelComemorativeNotification(identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        print("Notificação de data comemorativa cancelada com sucesso!")
    }
    
}
