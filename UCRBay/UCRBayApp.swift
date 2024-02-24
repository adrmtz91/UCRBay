//  UCRBayApp.swift
//  UCRBay
//
//  Created by AM on 2/11/24.
//

import SwiftUI
import Firebase
import UIKit

// AppDelegate for additional setup, especially for Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct UCRBayApp: App {
    // The delegate property should be declared correctly without type annotation
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userViewModel = UserViewModel()  // Assuming UserViewModel is the correct class name

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userViewModel)  // Providing the UserViewModel to your ContentView
        }
    }
}
