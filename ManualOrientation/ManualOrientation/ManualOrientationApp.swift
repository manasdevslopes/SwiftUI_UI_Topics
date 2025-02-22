//
//  ManualOrientationApp.swift
//  ManualOrientation
//
//  Created by MANAS VIJAYWARGIYA on 22/02/25.
//

import SwiftUI

@main
struct ManualOrientationApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  /// If you begin with portrait mode, set this to portrait
  static var orientation: UIInterfaceOrientationMask = .all
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    return true
  }
  
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return Self.orientation
  }
}
