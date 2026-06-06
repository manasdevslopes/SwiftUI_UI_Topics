//
// OpeningStatusPill.swift
// Opening Hours
//
// Created by MANAS VIJAYWARGIYA on 06/06/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct OpeningStatusPill: View {
  @Environment(OpeningHoursViewModel.self) private var viewModel
  @State private var pulse: Bool = false
  
  var body: some View {
    let status = viewModel.currentStatus()
    HStack(spacing: 6) {
      ZStack {
        if status.shouldPulse {
          Circle().fill(status.dotColor.opacity(0.55)).frame(width: 10, height: 10)
            .scaleEffect(pulse ? 2.2 : 1.0).opacity(pulse ? 0 : 0.9)
        }
        Circle().fill(status.dotColor).frame(width: 8, height: 8)
      }
      .frame(width: 18, height: 18)
      
      Text(status.label).font(.system(size: 13, weight: .semibold))
        .foregroundStyle(Color.primary)
    }
    .padding(.horizontal, 10).padding(.vertical, 5)
    .background(Capsule().fill(status.backgroundColor))
    .onAppear {
      guard status.shouldPulse else { return }
      withAnimation(.easeOut(duration: 2).repeatForever(autoreverses: false)) {
        pulse = true
      }
    }
  }
}

#Preview {
  OpeningStatusPill()
    .environment(OpeningHoursViewModel(chargingStation: .preview24x7))
}
