//
//  ViewController.swift
//  Project21
//
//  Created by Karol Harasim on 24/09/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UserNotifications
import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleTapped))
    }
    @objc func scheduleTapped() {
        scheduleLocal(in: 5)
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) {
            (granted, error) in
            if granted {
                print("Yay")
            } else {
                print("Nay")
            }
        }
        
    }
    
    @objc func scheduleLocal(in time: Int) {
        
        registerCategories()
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(time), repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Title goes here"
        content.body = "Main text goes here"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzBuzz"]
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let remind = UNNotificationAction(identifier: "remind", title: "Remind me later", options: [])
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, remind], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //pull out the burried userInfo dictionary
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom Data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                let ac = UIAlertController(title: "You opened the app by swiping right", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Close", style: .cancel))
                present(ac, animated: true)
            case "show":
                print("Show more information...")
                let ac = UIAlertController(title: "You opened the app by clicking Tell me more", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Close", style: .cancel))
                present(ac, animated: true)
            case "remind":
                scheduleLocal(in: 86400)
            default:
                break
            }
        }
        // you must call the completion handler when you're done
        completionHandler()
    }

}

