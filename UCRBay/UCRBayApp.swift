//  UCRBayApp.swift
//  UCRBay
//
//  Created by AM on 2/11/24.
//

import SwiftUI
import Firebase
import FirebaseAppCheck
import UIKit

// AppDelegate for additional setup, especially for Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Set up the App Check provider factory for App Attest.
        if #available(iOS 14.0, *) {
            AppCheck.setAppCheckProviderFactory(AppAttestProviderFactory())
        } else {
            AppCheck.setAppCheckProviderFactory(DeviceCheckProviderFactory())
        }
        
        FirebaseApp.configure()
        print("Firebase has been configured successfully.")
        return true
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
