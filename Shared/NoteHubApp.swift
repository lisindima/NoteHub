//
//  NoteHubApp.swift
//  Shared
//
//  Created by Дмитрий Лисин on 07.07.2020.
//

import SwiftUI
import Purchases

@main
struct NoteApp: App {
    
    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    #else
    @NSApplicationDelegateAdaptor(NSAppDelegate.self) private var appDelegate
    #endif
    
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}

#if os(iOS)
class AppDelegate: UIResponder, UIApplicationDelegate, PurchasesDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Purchases.configure(withAPIKey: "KqxRlxVJObhJFLWuNPVVPZzhckgXHjtZ")
        Purchases.debugLogsEnabled = true
        Purchases.shared.delegate = self
        return true
    }
    
    func purchases(_ purchases: Purchases, didReceiveUpdated purchaserInfo: Purchases.PurchaserInfo) {
        PurchasesStore.shared.listenPurchases()
    }
}
#else
class NSAppDelegate: NSObject, NSApplicationDelegate, PurchasesDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        Purchases.configure(withAPIKey: "KqxRlxVJObhJFLWuNPVVPZzhckgXHjtZ")
        Purchases.debugLogsEnabled = true
        Purchases.shared.delegate = self
    }
    
    func purchases(_ purchases: Purchases, didReceiveUpdated purchaserInfo: Purchases.PurchaserInfo) {
        PurchasesStore.shared.listenPurchases()
    }
}
#endif
