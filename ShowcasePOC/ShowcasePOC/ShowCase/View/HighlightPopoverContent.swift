//
// HighlightPopoverContent.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 26/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct HighlightPopoverContent: View {
  let highlight: Highlight
  var onSkip: () -> ()
  var onNext: () -> ()
  
  var body: some View {
    VStack {
      Text(highlight.title).applyCommonStyle(font: .custom("Arial-BoldMT", size: 10.0), frameWidth: nil)
        .lineLimit(1).padding(.top, 4).padding(.bottom, 4)
      
      Text(highlight.subtitle).applyCommonStyle(font: .custom("ArialMT", size: 7.5), frameWidth: 140, alignment: .center)
        .padding(.horizontal, 16).padding(.bottom, 5)
      
      HStack(alignment: .center) {
        Text("\(highlight.order + 1)/10").applyCommonStyle(font: .custom("Arial-BoldMT", size: 7.5), frameWidth: 38.8, alignment: .center)
          .foregroundStyle(.secondary)
        Spacer()
        Button {
          onSkip()
        } label: {
          Text(LocalizationManager.shared.localizedString(forKey: "skip")).applyCommonStyle(font: .custom("Roboto-Regular", size: 11.0), frameWidth: nil)
            .foregroundStyle(.primary).frame(height: 12.0, alignment: .center)
        }
        Spacer()
        Button {
          onNext()
        } label: {
          Image(systemName: "chevron.right").font(.system(size: 10)).foregroundStyle(.white).frame(width: 22.5, height: 16.5).padding(4)
            .background(Color.black).clipShape(.capsule(style: .continuous))
        }
      }
      .padding(.horizontal, 8)
    }
    .padding(.vertical, 10)
    /// iOS 16.4 modifier
    .presentationCompactAdaptation(.popover)
    .interactiveDismissDisabled()
  }
}

extension View {
  func applyCommonStyle(font: Font, frameWidth: CGFloat?, alignment: Alignment = .center) -> some View {
    self.font(font).multilineTextAlignment(.center).frame(width: frameWidth, alignment: alignment)
  }
}
