//
// ScreenA.swift
// BannerToast
//
// Created by MANAS VIJAYWARGIYA on 27/11/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct ScreenA: View {
  @State private var showB = false
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 20) {
        Text("Screen A")
          .font(.largeTitle)
        
        Button("Go to Screen B") {
          showB = true
        }
      }
      .navigationDestination(isPresented: $showB) {
        ScreenB()
      }
    }
  }
}

#Preview {
  ScreenA()
}
