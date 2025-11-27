//
// InlineToastData.swift
// BannerToast
//
// Created by MANAS VIJAYWARGIYA on 27/11/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct InlineToastData<T: View> {
  let type: InlineMessageType
  let hyperlinkText: String?
  let placeholderText: String?
  let tappableText: String?
  let fontSize: CGFloat
  let textColor: UIColor
  let linkColor: UIColor
  let showBorder: Bool
  let onHyperlinkTap: (() -> Void)?
  let onDismiss: (() -> Void)?
  let leadingContent: () -> T
  let hasLeading: Bool
  
  // Full initializer WITH leadingContent
  init(
    type: InlineMessageType,
    hyperlinkText: String? = nil,
    placeholderText: String? = nil,
    tappableText: String? = nil,
    fontSize: CGFloat = 16,
    textColor: UIColor = .darkGray,
    linkColor: UIColor = .green,
    showBorder: Bool = false,
    onHyperlinkTap: (() -> Void)? = nil,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder leadingContent: @escaping () -> T
  ) {
    self.type = type
    self.hyperlinkText = hyperlinkText
    self.placeholderText = placeholderText
    self.tappableText = tappableText
    self.fontSize = fontSize
    self.textColor = textColor
    self.linkColor = linkColor
    self.showBorder = showBorder
    self.onHyperlinkTap = onHyperlinkTap
    self.onDismiss = onDismiss
    self.leadingContent = leadingContent
    self.hasLeading = true
  }
}

// Convenience initializer WITHOUT leadingContent (T == EmptyView)
extension InlineToastData where T == EmptyView {
  init(
    type: InlineMessageType,
    hyperlinkText: String? = nil,
    placeholderText: String? = nil,
    tappableText: String? = nil,
    fontSize: CGFloat = 16,
    textColor: UIColor = .darkGray,
    linkColor: UIColor = .green,
    showBorder: Bool = false,
    onHyperlinkTap: (() -> Void)? = nil,
    onDismiss: (() -> Void)? = nil
  ) {
    self.type = type
    self.hyperlinkText = hyperlinkText
    self.placeholderText = placeholderText
    self.tappableText = tappableText
    self.fontSize = fontSize
    self.textColor = textColor
    self.linkColor = linkColor
    self.showBorder = showBorder
    self.onHyperlinkTap = onHyperlinkTap
    self.onDismiss = onDismiss
    self.leadingContent = { EmptyView() }
    self.hasLeading = false
  }
}
