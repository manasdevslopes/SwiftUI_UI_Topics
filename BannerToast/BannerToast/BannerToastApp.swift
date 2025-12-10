//
// BannerToastApp.swift
// BannerToast
//
// Created by MANAS VIJAYWARGIYA on 27/11/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

@main
struct BannerToastApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().globalInlineToast()
        }
    }
}

// MARK: - .globalInlineToast()
/* It has to be used on Root File, also add this when in modals like sheet , fullscreen etc... */
/*.fullScreenCover(isPresented: $states) {
    VStack {}
      .globalInlineToast()
  }
*/
