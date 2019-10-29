//
//  MakeNotification.swift
//  Notification
//
//  Created by EricM on 10/29/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation
import UserNotifications

struct MakeNotification {
    
    static func configureAlerts(identifier: String, title: String, body: String, time: Double){
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: body, arguments: nil)
        content.sound = .defaultCritical
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: title, content: content, trigger: trigger)
        center.add(request) {error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
