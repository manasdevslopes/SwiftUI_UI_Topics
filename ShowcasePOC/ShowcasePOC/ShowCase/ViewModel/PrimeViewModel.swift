//
// PrimeViewModel.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 26/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

enum StationType {
  case electric, fuel
}

final class PrimeViewModel: ObservableObject {
  @Published var selectedStationType: StationType = .electric
  @Published var isMenuVisible: Bool = false
  
  @MainActor
  func changeStationType(to stationType: StationType) {
    self.selectedStationType = stationType
  }
  
  func showMenu() {
    withAnimation { isMenuVisible = true }
  }
  
  func hideMenu() {
    withAnimation { isMenuVisible = false }
  }
  
  func hideSemiViewsOverTheMap() {
    if isMenuVisible { hideMenu() }
  }
}
