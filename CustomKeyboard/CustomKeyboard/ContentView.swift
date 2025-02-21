//
//  ContentView.swift
//  CustomKeyboard
//
//  Created by MANAS VIJAYWARGIYA on 21/02/25.
//

import SwiftUI

struct ContentView: View {
  @State private var text: String = ""
  @FocusState private var isActive: Bool
  
  var body: some View {
    let _ = print("isActive : \(isActive)")
    return NavigationStack {
      ZStack {
        Color.clear.contentShape(Rectangle()).onTapGesture { isActive = false }
        CustomTextFieldWithKeyboard {
          TextField("App Pin Code", text: $text)
            .padding(.vertical, 10).padding(.horizontal, 15)
            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
            .background(.fill, in: .rect(cornerRadius: 12)).focused($isActive)
        } keyboard: {
          CustomKeyboard(text: $text, isActive: $isActive)
        }
      }
      .navigationTitle("Custom Keyboard")
    }
  }
}

struct CustomKeyboard: View {
  @Binding var text: String
  @FocusState.Binding var isActive: Bool
  @State private var shuffledNumbers: [Int] = Array(0...9).shuffled()
  
  var body: some View {
    LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 3), spacing: 10) {
      ForEach(shuffledNumbers.prefix(9), id: \.self) { index in
        ButtonView("\(index)")
      }
      ButtonView("delete.backward.fill", isImage: true).disabled(text.isEmpty)
      if let lastNumber = shuffledNumbers.last {
        ButtonView("\(lastNumber)")
      }
      ButtonView("checkmark.circle.fill", isImage: true)
    }
    .padding(15)
    .background(.background.shadow(.drop(color: .black.opacity(0.08), radius: 5, x: 0, y: -5)))
    .onAppear {
      shuffledNumbers = Array(0...9).shuffled()
    }
  }
  
  @ViewBuilder
  func ButtonView(_ value: String, isImage: Bool = false) -> some View {
    Button {
      if isImage {
        if value == "delete.backward.fill" && !text.isEmpty {
          /// Delete last character
          text.removeLast()
        }
        if value == "checkmark.circle.fill" {
          /// Close Keyboard
          isActive = false
        }
      } else {
        text += value
      }
    } label: {
      Group {
        if isImage {
          Image(systemName: value)
        } else {
          Text(value)
        }
      }
      .font(.title3).fontWeight(.semibold).frame(width: 50, height: 50)
      .background {
        if !isImage {
          RoundedRectangle(cornerRadius: 10)
            .fill(.background.shadow(.drop(color: .black.opacity(0.08), radius: 3, x: 0, y: 0)))
        }
      }
      .foregroundStyle(Color.primary)
    }
  }
}

#Preview {
  ContentView()
}
