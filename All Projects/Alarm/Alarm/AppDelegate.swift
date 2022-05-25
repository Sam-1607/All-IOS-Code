//
//  AppDelegate.swift
//  Alarm
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let center = UNUserNotificationCenter.current()
        let snoozeAction = UNNotificationAction(identifier: Alarm.snoozeActionID, title: "Snooze", options: [])
        let alarmCategory = UNNotificationCategory(identifier: Alarm.notificationCategoryID, actions: [snoozeAction], intentIdentifiers: [], options: [])
        center.delegate = self
        center.setNotificationCategories([alarmCategory])
        return true
    }
}

