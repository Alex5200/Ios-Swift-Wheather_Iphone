//
//  NotificationViewController.swift
//  notaficaionWheather
//
//  Created by Александр Ляхов on 14.09.2021.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import Foundation
import CoreLocation

class NotificationViewController: UIViewController, UNNotificationContentExtension, CLLocationManagerDelegate {
    @objc func receivedMsg() {
        print("MSG Received")
   }
    @IBOutlet var label: UILabel?
   
    @IBOutlet weak var labelNot: UILabel!
    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        if let stringOne = defaults.string(forKey: "MTemp") {
            
            NotificationCenter.default.addObserver(self, selector: #selector(receivedMsg), name: Notification.Name("\(stringOne)"), object: nil)
        }
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }

}
