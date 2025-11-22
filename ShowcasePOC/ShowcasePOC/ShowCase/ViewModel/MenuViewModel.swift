//
// MenuViewModel.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 22/11/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

class MenuViewModel: ObservableObject {
  @Published var isShowingSelectedMenuOptionView: Bool = false
  @Published var selectedMenuOptionView: AnyView?
  static let shared = MenuViewModel()
  
  func navigateToUserProfile() {
    selectedMenuOptionView = AnyView(MyAccount())
    isShowingSelectedMenuOptionView = true
  }
  
  func navigateToChargingHistory() {
    selectedMenuOptionView = AnyView(ChargingHistory())
    isShowingSelectedMenuOptionView = true
  }
  
  func navigateToVehicle() {
    selectedMenuOptionView = AnyView(MyVehicle())
    isShowingSelectedMenuOptionView = true
  }
  
  func navigateToCards() {
    selectedMenuOptionView = AnyView(MyFuelAndChargeCards())
    isShowingSelectedMenuOptionView = true
  }
}
