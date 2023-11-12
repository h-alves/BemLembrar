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
    
    func scheduleNotification(identifier: String, type: String, fullName: String, date: DateComponents, repeats: Bool) {
        let content = UNMutableNotificationContent()
        content.title = fullName
        content.body = fullName
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: repeats)
        let id = identifier + type
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Houve um erro ao agendar a notificação: \(error)")
            } else {
                print("Notificação agendada com sucesso!")
            }
        }
        
        print("Tentativa de agendar uma notificação")
    }

    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func cancelNotification(identifier: String, type: String) {
        let id = identifier + type
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
}
