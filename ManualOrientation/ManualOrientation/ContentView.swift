//
//  ContentView.swift
//  ManualOrientation
//
//  Created by MANAS VIJAYWARGIYA on 22/02/25.
//

import SwiftUI

enum Orientation: String, CaseIterable {
  case all = "All"
  case portrail = "Portrait"
  case landscapeLeft = "Left"
  case landscapeRight = "Right"
  
  var mask: UIInterfaceOrientationMask {
    switch self {
      case .all: return .all
      case .portrail: return .portrait
      case .landscapeLeft: return .landscapeLeft
      case .landscapeRight: return .landscapeRight
    }
  }
}
struct ContentView: View {
  @State private var orientation: Orientation = .portrail
  @State private var showFullScreenCover: Bool = false
  
  var body: some View {
    NavigationStack {
      List {
        Section("Orientation") {
          /// Regular Segmented Picker
          Picker("", selection: $orientation) {
            ForEach(Orientation.allCases, id: \.rawValue) { orientation in
              Text(orientation.rawValue).tag(orientation)
            }
          }
          .pickerStyle(.segmented)
          .onChange(of: orientation, initial: true) { oldValue, newValue in
            modifyOrientation(newValue.mask)
          }
        }
        
        Section("Actions") {
          NavigationLink("Detail View") {
            DetailView(userSelection: orientation)
          }
          
          Button("Show Full Screen Cover") {
            modifyOrientation(.landscapeRight)
            /// The reason DispatchQueue used, to have animation for the full-screen cover as well
            DispatchQueue.main.async {
              showFullScreenCover.toggle()
            }
          }
        }
      }
      .navigationTitle("Manual Orientation")
      .fullScreenCover(isPresented: $showFullScreenCover) {
        Rectangle().fill(.red.gradient)
          .overlay {
            Text("Hello from Full Screen Cover!")
          }
          .ignoresSafeArea()
          .overlay(alignment: .topTrailing) {
            Button("Close") {
              modifyOrientation(orientation.mask)
              showFullScreenCover.toggle()
            }
            .padding(15)
          }
      }
    }
  }
}

struct DetailView: View {
  var userSelection: Orientation
  @Environment(\.dismiss) private var dismiss
  @State private var isRotated: Bool = false
  
  var body: some View {
    NavigationLink("Sub-Detail View") {
      Text("Hello from Sub-Detail View!")
        .onAppear {
          modifyOrientation(.portrait)
        }
        .onDisappear {
          /// Only available for landscape-left mode
          modifyOrientation(.landscapeLeft)
        }
    }
    .onAppear {
      guard !isRotated else { return }
      /// Only available for landscape-left mode
      modifyOrientation(.landscapeLeft)
      isRotated = true
    }
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button("Back") {
          modifyOrientation(userSelection.mask)
          DispatchQueue.main.async {
            dismiss()
          }
        }
      }
    }
  }
}
#Preview {
  ContentView()
}

extension View {
  /// Easy to use function to update orientation anywhere in view scope
  func modifyOrientation(_ mask: UIInterfaceOrientationMask) {
    if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
      /// Finally Limiting the auto-rotation by setting orientation mask on AppDelegate
      AppDelegate.orientation = mask
      windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: mask))
      /// Updating Root View Controller
      windowScene.keyWindow?.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
    }
  }
}
