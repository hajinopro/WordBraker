//
//  Notification.swift
//  WordBraker
//
//  Created by 하진호 on 2022/12/24.
//

import Foundation
import UserNotifications

struct Notification {
    static func notificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("All set!")
            } else if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    static func notificationRequest(_ word: Word) {
        let content = UNMutableNotificationContent()
        content.title = "\(word.question)"
        content.subtitle = "\(word.answer)"
        content.body = "\(word.sentence)"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}


