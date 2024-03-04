//  UCRBayApp.swift
//  UCRBay
//
//  Created by AM on 2/11/24.
//

import SwiftUI
import Firebase
import FirebaseAppCheck
import UIKit
import FirebaseMessaging
import GoogleSignIn

// AppDelegate for additional setup, especially for Firebase
class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Set up the App Check provider factory for App Attest.
        if #available(iOS 14.0, *) {
            AppCheck.setAppCheckProviderFactory(AppAttestProviderFactory())
        } else {
            AppCheck.setAppCheckProviderFactory(DeviceCheckProviderFactory())
        }
        
        FirebaseApp.configure()
        print("Firebase has been configured successfully.")
        
        // Messaging delegate
        Messaging.messaging().delegate = self
        
        
        // Google Sign-In configuration
        if let clientID = FirebaseApp.app()?.options.clientID {
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
        }
        return true
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
    }
        
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([[.banner, .sound]])
    }
        
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

// App Attest provider factory.
@available(iOS 14.0, *)
class AppAttestProviderFactory: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        return AppAttestProvider(app: app)
    }
}
class DeviceCheckProviderFactory: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        return DeviceCheckProvider(app: app)
    }
}

@main
struct UCRBayApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userViewModel = UserViewModel()  // Assuming UserViewModel is the correct class name

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userViewModel)  // Providing the UserViewModel to your ContentView
        }
    }
}
