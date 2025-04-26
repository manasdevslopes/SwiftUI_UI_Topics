//
// ShowcasePOCApp.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 26/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

@main
struct ShowcasePOCApp: App {
  @StateObject var primeViewModel = PrimeViewModel()
  
    var body: some Scene {
        WindowGroup {
          HomeView()
            .environmentObject(primeViewModel)
        }
    }
}
