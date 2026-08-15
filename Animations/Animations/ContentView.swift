//
// ContentView.swift
// Animations
//
// Created by MANAS VIJAYWARGIYA on 15/08/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
          AnimatedButton(text: "Animated button", action: { })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
