//
// OverlaySkipButton.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 01/05/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct OverlaySkipButton: View {
  @Binding var showView: Bool
  var onFinished: () -> Void
    var body: some View {
      VStack {
        Text(LocalizationManager.shared.localizedString(forKey: "skip_tutorial"))
          .applyCommonStyle(font: .system(size: 11))
          .multilineTextAlignment(.center)
          .kerning(0.1)
          .frame(height: 12.0, alignment: .center)
      }
      .frame(width: 89.5, height: 35.5)
      .background(.white)
      .opacity(0.99)
      .clipShape(RoundedRectangle(cornerRadius: 21.5, style: .continuous))
      .onTapGesture {
        print("Skipped")
        showView = false
        onFinished()
      }
    }
}

#Preview {
  OverlaySkipButton(showView: .constant(true), onFinished: { })
}
