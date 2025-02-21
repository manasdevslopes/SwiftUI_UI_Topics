//
//  ContentView.swift
//  TextFieldMenu
//
//  Created by MANAS VIJAYWARGIYA on 21/02/25.
//

import SwiftUI

struct ContentView: View {
  @State private var message: String = ""
  @State private var showSuggestions: Bool = true
  
  var body: some View {
    NavigationStack {
      List {
        Section("TextField") {
          TextField("Message", text: $message)
            .menu(showSuggestions: $showSuggestions) {
              TextFieldAction(title: "Uppercased") { _, textField in
                if let selectionRange = textField.selectedTextRange,
                   let selectedText = textField.text(in: selectionRange) {
                  let upperCasedText = selectedText.uppercased()
                  textField.replace(selectionRange, withText: upperCasedText)
                  
                  textField.selectedTextRange = selectionRange
                }
              }
              TextFieldAction(title: "Lowercased") { _, textField in
                if let selectionRange = textField.selectedTextRange,
                   let selectedText = textField.text(in: selectionRange) {
                  let lowerCasedText = selectedText.lowercased()
                  textField.replace(selectionRange, withText: lowerCasedText)
                  
                  textField.selectedTextRange = selectionRange
                }
              }
              
              TextFieldAction(title: "Replace") { range, textField in
                if let selectionRange = textField.selectedTextRange {
                  let replacementText = "Hello, World!"
                  textField.replace(selectionRange, withText: replacementText)
                  if let start = textField.position(from: selectionRange.start, offset: 0),
                     let end = textField.position(from: selectionRange.start, offset: replacementText.count) {
                    textField.selectedTextRange = textField.textRange(from: start, to: end)
                  }
                }
              }
            }
        }
        
        if !message.isEmpty {
          Section {
            Text(message)
          }
        }
        
        Section("Properties") {
          Toggle("Turn On Suggestions", isOn: $showSuggestions)
            .toggleStyle(SwitchToggleStyle(tint: .blue))
        }
      }
      .navigationTitle("Custom TextField Menu")
    }
  }
}

#Preview {
  ContentView()
}
