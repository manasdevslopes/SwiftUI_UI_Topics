//
//  ContentView.swift
//  OptionalModifiers
//
//  Created by MANAS VIJAYWARGIYA on 21/02/25.
//

import SwiftUI

enum Effect: String, CaseIterable {
  case bounce = "Bounce"
  case breathe = "Breathe"
  case pulse = "Pulse"
  case rotate = "Rotate"
}

struct ContentView: View {
  @State private var effect: Effect = .bounce
  
  var body: some View {
    Group {
      Picker("", selection: $effect) {
        ForEach(Effect.allCases, id: \.rawValue) { Text($0.rawValue).tag($0) }
      }
      .pickerStyle(SegmentedPickerStyle()).padding(15)
      
      Image(systemName: "heart.fill")
        .font(.largeTitle).foregroundStyle(.red.gradient)
        .modifier { image in
          switch effect {
            case .bounce: image.symbolEffect(.bounce)
            case .breathe: image.symbolEffect(.breathe)
            case .pulse: image.symbolEffect(.pulse)
            case .rotate: image.symbolEffect(.rotate)
          }
        }
      
      Rectangle()//.fill(.red)
        .modifier { rect in
          switch effect {
            case .bounce: rect.fill(.red)
            case .breathe: rect.fill(.blue)
            case .pulse: rect.fill(.purple)
            case .rotate: rect.fill(.black)
          }
        }
        .frame(width: 50, height: 50)
      
      Group {
        if effect == .bounce {
          Image(systemName: "heart.fill")
            .font(.largeTitle).foregroundStyle(.red.gradient).symbolEffect(.bounce)
        } else if effect == .breathe {
          Image(systemName: "heart.fill")
            .font(.largeTitle).foregroundStyle(.red.gradient).symbolEffect(.breathe)
        } else if effect == .pulse {
          Image(systemName: "heart.fill")
            .font(.largeTitle).foregroundStyle(.red.gradient).symbolEffect(.pulse)
        } else {
          Image(systemName: "heart.fill")
            .font(.largeTitle).foregroundStyle(.red.gradient).symbolEffect(.rotate)
        }
      }
    }
  }
}

extension View {
  @ViewBuilder
  func modifier<Content: View>(@ViewBuilder content: @escaping (Self) -> (Content)) -> some View {
    content(self)
  }
}

#Preview {
  ContentView()
}
