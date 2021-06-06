//
//  LocalNotificationManager.swift
//  To-do list
//
//  Created by Damian Mikołajczak on 05/06/2021.
//

import Foundation
import UIKit
import UserNotifications

class LocalNotificationManager {
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestForAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {succes, error in })
    }
    
    func addLocalNotification(categoryIdentifier: String, title: String, body: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = categoryIdentifier
        content.title = title
        content.body = body
        
        let notificationDate = date-TimeInterval(600)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "NotificationID", content: content, trigger: trigger)
        
        notificationCenter.add(request, withCompletionHandler: nil)
    }
}
