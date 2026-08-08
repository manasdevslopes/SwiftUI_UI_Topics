//
// RefreshLoopApp.swift
// RefreshLoop
//
// Created by MANAS VIJAYWARGIYA on 08/08/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

@main
struct RefreshLoopApp: App {
  @StateObject var numberCountVM = NumberCountViewModel()
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(numberCountVM)
    }
  }
}
