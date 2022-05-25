//
//  Alarm.swift
//  Alarm
//
//  Created by Sam Hiatt  on 5/24/22.
//  Copyright © 2022 AppDev Training. All rights reserved.
//

import Foundation
import UserNotifications

struct Alarm {
    private var notificationID: String
    
    var date: Date
    
    init(date: Date, notificationID: String) {
        self.date = date
        self.notificationID = notificationID ?? UUID().uuidString
    }
    
   
    
    private func authorizeIfNeeded(completion: @escaping (Bool)-> ()) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
                
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound], completionHandler: { (granted, _) in
                    completion(granted)
                })
            case .denied, .provisional, .ephemeral:
                completion(false)
            case .authorized:
                completion(true)
                
            }
        }
    }
    
    func schedule(completion: @escaping (Bool)-> ()) {
        authorizeIfNeeded { (granted) in
            guard granted else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
                
                let content = UNMutableNotificationContent()
                content.title = "Alarm"
                content.body = "Beep Beep"
                content.sound = UNNotificationSound.default
                content.categoryIdentifier = Alarm.notificationCategoryID
                
                let triggeredComponents = Calendar.current.dateComponents([.minute, .hour, .day, .month, .year], from: self.date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggeredComponents, repeats: false)
                let request = UNNotificationRequest(identifier: self.notificationID, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) {
                    (error: Error?)  in
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
    }
    
    func unschedule() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationID])
        Alarm.scheduled = nil
    }
}

extension Alarm: Codable {
    static let notificationCategoryID = "AlarmNotification"
    static let snoozeActionID = "snooze"
    
   
    
    private static let alarmURL: URL = {
        guard let baseURL = FileManager.default.urls(for:
                .documentDirectory, in: .userDomainMask).first else {
            fatalError("Can't get URL for documents directory.")
        }
        return baseURL.appendingPathComponent("ScheduledAlarm")
    }()
    
    
    static var scheduled: Alarm? {
        get {
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
            NotificationCenter.default.post(name: .alarmUpdated, object: nil)
        }
    }
}
