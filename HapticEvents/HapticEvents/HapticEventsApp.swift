//
// HapticEventsApp.swift
// HapticEvents
//
// Created by MANAS VIJAYWARGIYA on 07/12/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

@main
struct HapticEventsApp: App {
  @StateObject private var hapticManager = HapticManager.shared

  var body: some Scene {
    WindowGroup {
      HapticEvents().environmentObject(hapticManager)
    }
  }
}
