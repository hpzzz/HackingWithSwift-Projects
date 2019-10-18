//
//  ViewController.swift
//  Project2
//
//  Created by Karol Harasim on 14/08/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UIKit
import NotificationCenter

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var score = 0
    var countries = [String]()
    var correctAnswer = 0
    var questionesSoFar = 0
    var highestScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let savedHighScore = defaults.object(forKey: "Highscore") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                highestScore = try jsonDecoder.decode(Int.self, from: savedHighScore)
            } catch {
                print(" Error loading highscore")
            }
        }
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
        scheduleNotification(in: 86400)
        askQuestion()
    }
    func askQuestion(action: UIAlertAction! = nil){
        questionesSoFar += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = "\(countries[correctAnswer].uppercased())\t\t Score: \(score)\t\t High score: \(highestScore)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }) { finished  in
                sender.transform = .identity
            }
        print(questionesSoFar)
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong, that's the flag of \(countries[sender.tag].firstUppercased)"
            score -= 1
        }
        if questionesSoFar != 10 {
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        } else {
            if score > highestScore {
                let ac = UIAlertController(title: title, message: "You just set up a high score!: \(score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Close", style: .destructive, handler: askQuestion))
                present(ac, animated: true)
                highestScore = score
                save()
                questionesSoFar = 0
                score = 0
            } else {
            let ac = UIAlertController(title: title, message: "Final score: \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Close", style: .destructive, handler: askQuestion))
            present(ac, animated: true)
            questionesSoFar = 0
            score = 0
        }
    }
    }
    @objc func infoButtonTapped(){
        let ac = UIAlertController(title: nil, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(ac, animated: true)
        
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(highestScore) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "Highscore")
        } else {
            print("Failed to save high score")
        }
        
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
    
    func scheduleNotification(in time: Int) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400 , repeats: true)
        
        let content = UNMutableNotificationContent()
           content.title = "Play the game today!"
           content.body = "Best way to remember countries flags is by daily playing this game"
           content.categoryIdentifier = "alarm"
           content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
}
extension StringProtocol {
    var firstUppercased: String {
        return prefix(1).uppercased()  + dropFirst()
    }
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}
