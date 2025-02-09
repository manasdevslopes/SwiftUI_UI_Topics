//
//  ContentView.swift
//  SizeClasses-SwiftUI
//
//  Created by MANAS VIJAYWARGIYA on 09/02/25.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.verticalSizeClass) var verticalSizeClass
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  
  var isLandscape: Bool {
    verticalSizeClass == .compact
  }
  
  var body: some View {
    Text(isLandscape ? "I'm landscape" : "I'm portrait")
      .foregroundStyle(isLandscape ? .red : .blue)
      .font(.largeTitle).bold().padding()
  }
}

#Preview {
  ContentView()
}
