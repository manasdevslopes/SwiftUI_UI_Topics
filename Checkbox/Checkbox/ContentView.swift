//
// ContentView.swift
// Checkbox
//
// Created by MANAS VIJAYWARGIYA on 06/10/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct ContentView: View {
  @State private var isRememberMeChecked: Bool = false
  
  var body: some View {
    HStack {
      Toggle("Remember me", isOn: $isRememberMeChecked)
        .toggleStyle(CheckboxToggleStyle(tintColor: Color.green))
    }
  }
}

struct CheckboxToggleStyle: ToggleStyle {
  var tintColor: Color
  
  func makeBody(configuration: Configuration) -> some View {
    return HStack(spacing: 10) {
      (configuration.isOn ? Image(systemName: "squareshape.fill") : Image(systemName: "squareshape"))
        .renderingMode(.template).resizable().foregroundStyle(configuration.isOn ? tintColor : .white)
        .frame(width: 15, height: 15).padding(5)
        .border(Color.gray, width: 1)
      
      Label {
        configuration.label
      } icon: {}
        .font(.system(size: 14)).multilineTextAlignment(.leading)
        .lineSpacing(4).foregroundStyle(configuration.isOn ? tintColor : Color.gray)
    }
    .onTapGesture { configuration.isOn.toggle() }
  }
}

#Preview {
  ContentView()
}
