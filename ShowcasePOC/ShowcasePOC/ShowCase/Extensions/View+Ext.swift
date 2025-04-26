//
// View+Ext.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 26/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

extension View {
  /// Custom Showcase View Extension
  @ViewBuilder
  func showCase(order: Int, title: String, subtitle: String, cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous, scale: CGFloat = 1) -> some View {
    self
    /// Storing it in Anchor Preferences
      .anchorPreference(key: HighlightAnchorKey.self, value: .bounds) { anchor in
        let highlight = Highlight(anchor: anchor, order: order, title: title, subtitle: subtitle, cornerRadius: cornerRadius, style: style, scale: scale)
        return [order : highlight]
      }
  }
  
  /// Custom View modifier for Inner/Reverse Mask
  @ViewBuilder
  func reverseMask<Content: View>(alignment: Alignment = .topLeading, @ViewBuilder content: @escaping () -> Content) -> some View {
    self
      .mask {
        Rectangle()
          .overlay(alignment: .topLeading) {
            content()
              .blendMode(.destinationOut)
          }
      }
  }
}
