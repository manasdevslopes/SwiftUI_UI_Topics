//
// MyVehicle.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 22/11/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct MyVehicle: View {
  @ObservedObject var menuViewModel = MenuViewModel.shared
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Text("My Vehicle")
      .onTapGesture {
        menuViewModel.isShowingSelectedMenuOptionView = false
        dismiss()
      }
  }
}

#Preview {
  MyVehicle()
}
