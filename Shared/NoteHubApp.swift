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
    
    #if !os(macOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#if !os(macOS)
class AppDelegate: NSObject, UIApplicationDelegate, PurchasesDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Purchases.configure(withAPIKey: "KqxRlxVJObhJFLWuNPVVPZzhckgXHjtZ")
        Purchases.shared.delegate = self
        return true
    }
    
    func purchases(_ purchases: Purchases, didReceiveUpdated purchaserInfo: Purchases.PurchaserInfo) {
        PurchasesStore.shared.listenPurchases()
    }
}
#endif
