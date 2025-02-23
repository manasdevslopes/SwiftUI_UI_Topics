//
//  ContentView.swift
//  FloatingBottomSheet
//
//  Created by MANAS VIJAYWARGIYA on 23/02/25.
//

import SwiftUI

struct ContentView: View {
  @State private var showSheet: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        Button("Show Sheet") {
          showSheet.toggle()
        }
      }
      .navigationTitle("Floating Bottom Sheet")
    }
    .floatingBottomSheet(isPresented: $showSheet) {
//      Text("Hello World").frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.background.shadow(.drop(radius: 5)), in: .rect(cornerRadius: 25)).padding(.horizontal, 15).padding(.top, 15)
//        .presentationDetents([.height(100), .height(330), .fraction(0.999)])
      SheetView(
        title: "Replace existing folder?",
        content: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem!",
        image: .init(
          content: "questionmark.folder.fill",
          tint: .blue,
          foreground: .white),
        button1: .init(
          content: "Replace",
          tint: .blue,
          foreground: .white),
        button2: .init(
          content: "Cancel",
          tint: Color.primary.opacity(0.08),
          foreground: Color.primary),
        button1Click: {},
        button2Click: { showSheet.toggle() }
      ).interactiveDismissDisabled()
      .presentationDetents([.height(330)]).presentationBackgroundInteraction(.enabled(upThrough: .height(330)))
    }
  }
}

/// Sample View
struct SheetView: View {
  var title: String
  var content: String
  var image: Config
  var button1: Config
  var button2: Config?
  var button1Click: () -> ()
  var button2Click: () -> ()
  
  var body: some View {
    VStack(spacing: 15) {
      Image(systemName: image.content).font(.title).foregroundStyle(image.foreground).frame(width: 65, height: 65)
        .background(image.tint.gradient, in: .circle)
      
      Text(title).font(.title3.bold())
      
      Text(content).font(.callout).multilineTextAlignment(.center).lineLimit(2).foregroundStyle(.gray)
      
      buttonView(button1, onPress: button1Click)
      
      if let button2 {
        buttonView(button2, onPress: button2Click)
      }
    }
    .padding([.horizontal, .bottom], 15)
    .background {
      RoundedRectangle(cornerRadius: 15).fill(.background).padding(.top, 30)
    }
    .shadow(color: .black.opacity(0.12), radius: 8).padding(.horizontal, 15)
  }
  
  @ViewBuilder
  func buttonView(_ config: Config, onPress: @escaping () -> ()) -> some View {
    Button {
      onPress()
    } label: {
      Text(config.content)
        .fontWeight(.bold).foregroundStyle(config.foreground).padding(.vertical, 10).frame(maxWidth: .infinity)
        .background(config.tint.gradient, in: .rect(cornerRadius: 10))
    }
  }
  
  struct Config {
    var content: String
    var tint: Color
    var foreground: Color
  }
}

#Preview {
  ContentView()
}
