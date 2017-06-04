//
//  NotificationObserver.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 6. 4..
//  Copyright © 2017년 tdl. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class NotificationObserver {
    
    let center = NotificationCenter.default
    
    func addObserver(hour: Int, minute: Int) {
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: option) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
                let content = UNMutableNotificationContent()
                content.title = "Don't forget"
                content.body = "Buy some milk"
                content.sound = UNNotificationSound.default()
                
                
                let date = Date(timeIntervalSinceNow: 3600)
                let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,
                                                            repeats: false)
                
                let identifier = "UYLLocalNotification"
                let request = UNNotificationRequest(identifier: identifier,
                                                    content: content, trigger: trigger)
                center.add(request, withCompletionHandler: { (error) in
                    if let error = error {
                        // Something went wrong
                    }
                })
            }
        }
        // A: 여기에 NotificationCenter 알림 등록 처리 작성
        // have to use NSCalendar for the components
     /*
 let calendar = NSCalendar(identifier: .gregorian)!;
        
        var dateFire = Date()
        
        // if today's date is passed, use tomorrow
        var fireComponents = calendar.components( [NSCalendar.Unit.day, NSCalendar.Unit.month, NSCalendar.Unit.year, NSCalendar.Unit.hour, NSCalendar.Unit.minute], from:dateFire)
        
        if (fireComponents.hour! > hour
            || (fireComponents.hour == hour && fireComponents.minute! >= minute) ) {
            
            dateFire = dateFire.addingTimeInterval(86400)  // Use tomorrow's date
            fireComponents = calendar.components( [NSCalendar.Unit.day, NSCalendar.Unit.month, NSCalendar.Unit.year, NSCalendar.Unit.hour, NSCalendar.Unit.minute], from:dateFire);
        }
        
        // set up the time
        fireComponents.hour = hour
        fireComponents.minute = minute
        
        // schedule local notification
        dateFire = calendar.date(from: fireComponents)!
        
        let localNotification = UILocalNotification()
        localNotification.fireDate = dateFire
        localNotification.alertBody = "Record Today Numerily. Be completely honest: how is your day so far?"
        localNotification.repeatInterval = NSCalendar.Unit.day
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        
        UIApplication.shared.scheduleLocalNotification(localNotification);
 */
 
    }
    func removeObserver() {
        // B: 여기에 NotificationCenter 알림 해제 처리 작성
        center.removeObserver(self)
    }
    
    // C: 이번 알림이 실행될 때 호출되는 메소드
    @objc private func notified(notification: Notification) {
        print("호출: \(notification)")
    }
}
