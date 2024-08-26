//
//  AppDelegate.swift
//  Giga_Chat
//
//  Created by Harsh Kumar on 14/08/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        let db = Firestore.firestore() ///Make sure you paste all these firebase function at the same place inside this application function
print(db) ///This is here to cheeck if the DB is Working
        IQKeyboardManager.shared.enable=true //This will enable IQ keyboard manager
        IQKeyboardManager.shared.enableAutoToolbar=false //This will disable the additional toolbar of IQ keyboard that we don't need
        IQKeyboardManager.shared.resignOnTouchOutside=true //This will Dismiss the keyboard if we touch anywhere
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


}

