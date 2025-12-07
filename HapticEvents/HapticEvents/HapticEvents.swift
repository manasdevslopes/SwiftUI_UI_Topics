//
// HapticEvents.swift
// HapticEvents
//
// Created by MANAS VIJAYWARGIYA on 07/12/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct HapticEvents: View {
  @State private var counter: [Int] = Array(repeating: 0, count: 18)
  
  private let columns: [GridItem] = [
    GridItem(.adaptive(minimum: 160), spacing: 12)
  ]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 14) {
        
        hapticButton("Increase", index: 0) { .increase }
        hapticButton("Alignment", index: 1) { .alignment }
        hapticButton("Decrease", index: 2) { .decrease }
        hapticButton("Error", index: 3) { .error }
        hapticButton("Impact", index: 4) { .impact }
        hapticButton("Level Change", index: 5) { .levelChange }
        hapticButton("Path Complete", index: 6) { .pathComplete }
        hapticButton("Selection", index: 7) { .selection }
        hapticButton("Start", index: 8) { .start }
        hapticButton("Stop", index: 9) { .stop }
        hapticButton("Success", index: 10) { .success }
        hapticButton("Warning", index: 11) { .warning }
        
        hapticButton("Impact Soft", index: 12) {
          .impact(flexibility: .soft, intensity: 0.5)
        }
        
        hapticButton("Impact Rigid", index: 13) {
          .impact(flexibility: .rigid, intensity: 0.5)
        }
        
        hapticButton("Impact Solid", index: 14) {
          .impact(flexibility: .solid, intensity: 1.0)
        }
        
        hapticButton("Impact Light", index: 15) {
          .impact(weight: .light, intensity: 1.0)
        }
        
        hapticButton("Impact Medium", index: 16) {
          .impact(weight: .medium, intensity: 1.0)
        }
        
        hapticButton("Impact Heavy", index: 17) {
          .impact(weight: .heavy, intensity: 1.0)
        }
      }
      .padding()
      
      // ✅ Core Haptics Anywhere Now
      LazyVGrid(columns: columns, spacing: 14) {
        
        Button("Complex Success") {
          HapticManager.shared.playSimpleSuccess()
        }
        
        Button("Complex Wave") {
          HapticManager.shared.playComplexWave()
        }
      }
      .padding()
    }
    .scrollIndicators(.hidden)
  }
  
  private func hapticButton(_ title: String, index: Int, feedback: @escaping () -> SensoryFeedback) -> some View {
    
    Button(title) {
      counter[index] += 1
    }
    .padding()
    .frame(maxWidth: .infinity)
    .background(.blue.opacity(0.12))
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .sensoryFeedback(feedback(), trigger: counter[index])
  }
}

#Preview {
  HapticEvents()
}
