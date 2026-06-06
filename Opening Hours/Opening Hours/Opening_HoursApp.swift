//
// Opening_HoursApp.swift
// Opening Hours
//
// Created by MANAS VIJAYWARGIYA on 06/06/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

@main
struct Opening_HoursApp: App {
    var body: some Scene {
        WindowGroup {
          ChargingStationDetailView(chargingStation: .preview24x7)
        }
    }
}
