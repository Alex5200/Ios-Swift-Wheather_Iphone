//
//  AppDelegate.swift
//  Wheather
//
//  Created by Александр Ляхов on 14.09.2021.
//

import UIKit
import UserNotifications
@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    let notafication = UNUserNotificationCenter.current()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        notafication.requestAuthorization(options: [.alert, .sound, .alert]) {
            (granted, error) in
            guard granted else {return}
            self.notafication.getNotificationSettings{(settings) in
                print(settings)
                guard settings.authorizationStatus == .authorized else {return}
            }
        }
        // Override point for customization after application launch.
        notafication.delegate = self
        sendNotafications()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

   
    func sendNotafications(){
        let w = Wheather()
        var temp = w.retTemp()
        let nf = UNMutableNotificationContent()
        nf.title = "Спасибо за использования приложения"
        nf.body = "\(String(temp)) C"
        nf.sound = UNNotificationSound.default
        let trig = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let req = UNNotificationRequest(identifier: "notafication", content: nf, trigger: trig)
        notafication.add(req){
            (error) in print(error?.localizedDescription)
        }
    }

}


extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notafication: UNNotification, withCompletionHandler completionHandler: @escaping(UNNotificationPresentationOptions) -> Void){
        completionHandler([.alert, .sound ])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationRequest, withCompletionHandler CompletionHandler: @escaping(UNNotificationPresentationOptions) -> Void){
        print(#function)
    }
}
