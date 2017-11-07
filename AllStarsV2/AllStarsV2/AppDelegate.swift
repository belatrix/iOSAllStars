//
//  AppDelegate.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 18/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import UserNotifications
// import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var fcmToken: String?
    fileprivate var deviceToken: String?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        
        let userDefault = UserDefaults.standard
        let versionApp = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        
        if userDefault.object(forKey: "isFirtsTime_v\(versionApp)") == nil {
            CDMKeyChain.eliminarKeychain()
            userDefault.set("1", forKey: "isFirtsTime_v\(versionApp)")
            userDefault.synchronize()
        }
        
        AppInformationBC.getAppInformation()
        /* GMSServices.provideAPIKey("AIzaSyAPN91Fur0N3HtQPlGpbxydc9wTACkmzpg") */
        
        
        Messaging.messaging().delegate = self
        //Messaging.messaging().shou
        
        if #available(iOS 10.0, *) { /* iOS 10 o superior */
            UNUserNotificationCenter.current().delegate = self
            
            let options: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: options, completionHandler: { (granted, error) in
                
                DispatchQueue.main.async {
                    print("User allows push notifications? \(granted ? "Yes!" : "No!") \(error == nil ? " " : "-> \(String(describing: error?.localizedDescription))")")
                    
                    if granted { /* El usuario permite recibir notificaciones. */
                        application.registerForRemoteNotifications()
                    }
                }
                
            })
            
        }
        else {
            
        }
        
        FirebaseApp.configure()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    
    
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "AllStarsV2")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    
    
    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}





extension AppDelegate {
    
    // MARK: - APN registration methods
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Register for remote notifications with device token: \(deviceToken)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Fail to register for remote notifications: \(error.localizedDescription)")
    }
    
    
    
    
    // MARK: - APN receive notifications methods
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
    }
    
}





extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // MARK: - UNUserNotificationCenterDelegate methods
    
    /**
     Called when a notification is delivered to a foreground app.
     If your app is in the foreground when a notification arrives, the notification center calls this method to deliver the notification directly to your app. If you implement this method, you can take whatever actions are necessary to process the notification and update your app. When you finish, execute the completionHandler block and specify how you want the system to alert the user, if at all.
     If your delegate does not implement this method, the system silences alerts as if you had passed the UNNotificationPresentationOptionNone option to the completionHandler block. If you do not provide a delegate at all for the UNUserNotificationCenter object, the system uses the notification’s original options to alert the user.
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        completionHandler([])
        
    }
    
    /**
     Called to let your app know which action was selected by the user for a given notification.
     Use this method to perform the tasks associated with your app’s custom actions. When the user responds to a notification, the system calls this method with the results. You use this method to perform the task associated with that action, if at all. At the end of your implementation, you must call the completionHandler block to let the system know that you are done processing the notification.
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler()
        
        print(userInfo)
        
    }
    
}





extension AppDelegate: MessagingDelegate {
    
    // MARK: - MessagingDelegate methods
    
    /**
     This method is called on iOS 10 devices to handle data messages received via FCM through its direct channel (not via APNS).
     For iOS 9 and below, the FCM data message is delivered via the UIApplicationDelegate's -application:didReceiveRemoteNotification: method.
     */
    func messaging(_ messaging: Messaging,
                   didReceive remoteMessage: MessagingRemoteMessage) {
        print("Remote message: \(remoteMessage.appData)")
    }
    
    /**
     This method will be called whenever FCM receives a new, default FCM token for your Firebase project's Sender ID.
     You can send this token to your application server to send notifications to this device.
     */
    func messaging(_ messaging: Messaging,
                   didRefreshRegistrationToken fcmToken: String) {
        
        self.fcmToken = fcmToken
        print("Firebase Cloud Messaging token: \(fcmToken)")
        
        guard let session = SessionBE.sharedInstance else { return }
        UserWebModel.registerDevice(fcmToken, toSession: session, withSuccessful: { (success) in
            //...
        }) { (error) in
            //...
        }
        
    }
    
}

