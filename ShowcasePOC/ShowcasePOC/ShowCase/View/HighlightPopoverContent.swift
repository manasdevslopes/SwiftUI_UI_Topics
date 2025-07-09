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
      Title()
      Description()
      HStack(alignment: .center) {
        Count()
        
        if highlight.step != .step10 {
          Spacer()
          TextButton(for: "skip", onSkip)
        }
        
        Spacer()
        
        if highlight.step == .step10 {
          TextButton(for: "finish", onNext)
        } else {
          ArrowButton()
        }
      }
      .padding(.horizontal, 8)
    }
    .padding([.vertical, .horizontal], 10)
    /// iOS 16.4 modifier
    .presentationCompactAdaptation(.popover)
    .interactiveDismissDisabled()
  }
}

extension View {
  func applyCommonStyle(font: Font, frameWidth: CGFloat? = nil, alignment: Alignment = .center) -> some View {
    self.font(font).multilineTextAlignment(.center).frame(width: frameWidth, alignment: alignment)
  }
}

// MARK: - Sub-Components
extension HighlightPopoverContent {
  @ViewBuilder private func Title() -> some View {
    Text(LocalizationManager.shared.localizedString(forKey: highlight.step.titleKey))
      .applyCommonStyle(font: .system(size: 14.0, weight: .bold)).lineLimit(1).padding(.vertical, 4)
  }
  
  @ViewBuilder private func Description() -> some View {
    Text(LocalizationManager.shared.localizedString(forKey: highlight.step.subtitleKey))
      .applyCommonStyle(font: .system(size: 10.0), frameWidth: 140, alignment: .center).padding(.horizontal, 16).padding(.bottom, 5)
      .foregroundStyle(.secondary)
  }
  
  @ViewBuilder private func Count() -> some View {
    Text(LocalizationManager.shared.localizedString(forKey: highlight.step.countKey))
      .applyCommonStyle(font: .system(size: 10.0, weight: .bold), frameWidth: 42.0, alignment: .center).foregroundStyle(.secondary)
  }
  
  @ViewBuilder private func TextButton(for key: String, _ action: @escaping () -> Void) -> some View {
    Button {
      action()
    } label: {
      Text(LocalizationManager.shared.localizedString(forKey: key)).applyCommonStyle(font: .system(size: 10.0, weight: .bold))
        .foregroundStyle(.black).frame(height: 12.0, alignment: .center)
    }
    .contentShape(Rectangle()).frame(height: 44)
  }
  
  @ViewBuilder private func ArrowButton() -> some View {
    Button {
      onNext()
    } label: {
      Image(systemName: "chevron.right").font(.system(size: 10)).foregroundStyle(.white).frame(width: 22.5, height: 16.5)
        .padding(4).background(.black).clipShape(.capsule(style: .continuous))
    }

  }
}
