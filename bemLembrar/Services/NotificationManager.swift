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
    
    func scheduleNotification(fullName: String, timeInterval: TimeInterval, repeats: Bool) {
        let content = UNMutableNotificationContent()
        content.title = fullName
        content.body = fullName
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: repeats)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
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
    
}
