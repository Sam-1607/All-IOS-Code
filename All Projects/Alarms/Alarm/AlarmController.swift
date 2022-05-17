//
//  AlarmController.swift
//  Alarm
//
//  Created by Sam Hiatt  on 4/4/22.
//  Copyright © 2022 AppDev Training. All rights reserved.
//

import Foundation
import UserNotifications

struct Alarm {
    
    var date: Date
    private var notificationID: String
    
    
    init(date: Date, notificationID: String? = nil) {
        self.notificationID = notificationID ?? UUID().uuidString
        self.date = date
    }
    
    func schedule(completion: @escaping (Bool) -> ()) {
        authorizeIfNeeded { (granted) in
            guard granted else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            let content = UNMutableNotificationContent()
            content.title = "Alarm"
            content.body = "Beep Beep"
            content.sound = UNNotificationSound.default
            content.categoryIdentifier = Alarm.notificationCategoryId
            
            let triggerDataComponents = Calendar.current.dateComponents([.minute, .hour, .day, .month, .year], from: self.date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDataComponents, repeats: false)
            let request = UNNotificationRequest(identifier: self.notificationID, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) {
                (error: Error?) in
                DispatchQueue.main.async {
                    if let error = error {
                        print(error.localizedDescription)
                        completion(false)
                    } else {
                        Alarm.scheduled = self
                        completion(true)
                    }
                }
            }
        }
    }
    
    func unschedule() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationID])
        Alarm.scheduled = nil
    }
    
    private func authorizeIfNeeded(completion: @escaping (Bool) -> ()) {
        let notifcationsCenter = UNUserNotificationCenter.current()
        
        notifcationsCenter.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized:
                completion(true)
                
            case .notDetermined:
                notifcationsCenter.requestAuthorization(options: [.alert, .sound], completionHandler: { (granted, _) in
                    completion(granted)
                })
                
            case .denied, .provisional:
                completion(false)
                
            default:
                return
            }
        }
    }
}

extension Alarm: Codable {
    
    static let notificationCategoryId = "AlarmNotification"
        static let snoozeActionID = "snooze"
     
        private static let alarmURL: URL = {
            guard let baseURL = FileManager.default.urls(for:
               .documentDirectory, in: .userDomainMask).first else {
                fatalError("Can't get URL for documents directory.")
            }
     
            return baseURL.appendingPathComponent("ScheduledAlarm")
        }()
   
    
    static var scheduled: Alarm? {
        get  {
            guard let data = try? Data(contentsOf: alarmURL) else {
                return nil
            }
            return try? JSONDecoder().decode(Alarm.self, from: data)
        }
        
        set {
            if let alarm = newValue {
                let data = try? JSONEncoder().encode(alarm)
                try? data?.write(to: alarmURL)
            } else {
                try? FileManager.default.removeItem(at: alarmURL)
            }
            
            NotificationCenter.default.post(name: .alarmUpDated, object: nil)
        }
    }
    
   
    
    
    static let schedule = Alarm?.self
}
