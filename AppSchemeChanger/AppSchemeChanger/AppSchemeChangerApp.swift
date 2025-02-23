//
//  AppSchemeChangerApp.swift
//  AppSchemeChanger
//
//  Created by MANAS VIJAYWARGIYA on 23/02/25.
//

import SwiftUI
// MARK: - This is Applicable from iOS 17 & iOS 18
@main
struct AppSchemeChangerApp: App {
  var body: some Scene {
    WindowGroup {
      SchemeHostView {
        ContentView()
      }
    }
  }
}
