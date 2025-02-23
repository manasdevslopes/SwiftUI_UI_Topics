//
//  ContentView.swift
//  AppSchemeChanger
//
//  Created by MANAS VIJAYWARGIYA on 23/02/25.
//

import SwiftUI

struct ContentView: View {
  @AppStorage("AppScheme") private var appScheme: AppScheme = .device
  @SceneStorage("ShowScenePickerView") private var showPickerView: Bool = false
  
  var body: some View {
    NavigationStack {
      Home()
        .navigationTitle("Messages")
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            Button {
              showPickerView.toggle()
            } label: {
              Image(systemName: appScheme.symbolImage).foregroundStyle(Color.primary)
            }
            .animation(.snappy, value: appScheme).buttonStyle(.plain)
          }
        }
    }
  }
}

#Preview {
  ContentView()
}
