//
// ContentView.swift
// CustomAlertView
//
// Created by MANAS VIJAYWARGIYA on 06/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct ContentView: View {
  @State private var showAlert = false
  @State private var showAlert1 = false
  @State private var showAlert2 = false
  var body: some View {
    NavigationStack {
      List {
        Section("Usage") {
          Text(
                        """
                        **.alert(isPresented) {**
                            /// Content
                        **} background: {**
                            /// Background
                        **}**
                        """
          )
          .monospaced()
          .lineSpacing(8)
        }
        
        Button("TextField Alert") {
          showAlert.toggle()
        }
        .alert(isPresented: $showAlert) {
          CustomDialog(
            title: "Folder Name",
            content: "Enter a file Name",
            image: .init(content: "folder.fill.badge.plus", tint: .blue, foreground: .white),
            button1: .init(content: "Save Folder", tint: .blue, foreground: .white, action: { folder in
              print(folder)
              showAlert = false
            }),
            button2: .init(content: "Cancel", tint: .red, foreground: .white, action: { _ in
              showAlert = false
            }),
            addsTextField: true,
            textFieldHint: "Personal Documents"
          )
          .transition(.blurReplace.combined(with: .scale(0.8)))
        } background: {
          Rectangle()
            .fill(.primary.opacity(0.35))
        }
        
        Button("Dialog Alert") {
          showAlert1.toggle()
        }
        .alert(isPresented: $showAlert1) {
          CustomDialog(
            title: "Replace Existing File?",
            content: "This will rewrite the existing file with the new file content.",
            image: .init(
              content: "questionmark.folder.fill",
              tint: .blue,
              foreground: .white
            ),
            button1: .init(
              content: "Replace",
              tint: .blue,
              foreground: .white,
              action: { _ in
                showAlert1 = false
              }
            ),
            button2: .init(
              content: "Cancel",
              tint: Color.primary.opacity(0.08),
              foreground: Color.primary,
              action: { _ in
                showAlert1 = false
              }
            )
          )
          .transition(.blurReplace.combined(with: .push(from: .bottom)))
        } background: {
          Rectangle()
            .fill(.primary.opacity(0.35))
        }
        
        Button("Alert") {
          showAlert2.toggle()
        }
        .alert(isPresented: $showAlert2) {
          CustomDialog(
            title: "Application Error",
            content: "There was an error while saving your file.\nPlease try again later.",
            image: .init(
              content: "externaldrive.fill.trianglebadge.exclamationmark",
              tint: .blue,
              foreground: .white
            ),
            button1: .init(
              content: "Done",
              tint: .red,
              foreground: .white,
              action: { _ in
                showAlert2 = false
              })
          )
          .transition(.blurReplace)
        } background: {
          Rectangle()
            .fill(.primary.opacity(0.35))
        }
      }
      .navigationTitle("Custom Alert")
    }
  }
}

#Preview {
  ContentView()
}

struct CustomDialog: View {
  var title: String
  var content: String?
  var image: Config
  var button1: Config
  var button2: Config?
  var addsTextField: Bool = false
  var textFieldHint: String = ""
  /// State Properties
  @State private var text: String = ""
  var body: some View {
    VStack(spacing: 15) {
      Image(systemName: image.content)
        .font(.title)
        .foregroundStyle(image.foreground)
        .frame(width: 65, height: 65)
        .background(image.tint.gradient, in: .circle)
        .background {
          Circle()
            .stroke(.background, lineWidth: 8)
        }
      
      Text(title)
        .font(.title3.bold())
      
      if let content {
        Text(content)
          .font(.system(size: 14))
          .multilineTextAlignment(.center)
          .lineLimit(2)
          .foregroundStyle(.gray)
          .padding(.vertical, 4)
      }
      
      if addsTextField {
        TextField(textFieldHint, text: $text)
          .padding(.horizontal, 15)
          .padding(.vertical, 12)
          .background {
            RoundedRectangle(cornerRadius: 10)
              .fill(.gray.opacity(0.1))
          }
          .padding(.bottom, 5)
      }
      
      ButtonView(button1)
      
      if let button2 {
        ButtonView(button2)
          .padding(.top, -5)
      }
    }
    .padding([.horizontal, .bottom], 15)
    .background {
      RoundedRectangle(cornerRadius: 15)
        .fill(.background)
        .padding(.top, 30)
    }
    .frame(maxWidth: 310)
    .compositingGroup()
  }
  
  /// Button View
  @ViewBuilder
  private func ButtonView(_ config: Config) -> some View {
    Button {
      config.action(addsTextField ? text : "")
    } label: {
      Text(config.content)
        .fontWeight(.bold)
        .foregroundStyle(config.foreground)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(config.tint.gradient, in: .rect(cornerRadius: 10))
    }
  }
  
  struct Config {
    var content: String
    var tint: Color
    var foreground: Color
    var action: (String) -> () = { _ in  }
  }
}
