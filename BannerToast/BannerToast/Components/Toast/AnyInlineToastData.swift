//
// AnyInlineToastData.swift
// BannerToast
//
// Created by MANAS VIJAYWARGIYA on 27/11/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct AnyInlineToastData {
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
  let leadingContent: AnyView
  
  init<T: View>(_ data: InlineToastData<T>) {
    self.type = data.type
    self.hyperlinkText = data.hyperlinkText
    self.placeholderText = data.placeholderText
    self.tappableText = data.tappableText
    self.fontSize = data.fontSize
    self.textColor = data.textColor
    self.linkColor = data.linkColor
    self.showBorder = data.showBorder
    self.onHyperlinkTap = data.onHyperlinkTap
    self.onDismiss = data.onDismiss
    self.leadingContent = AnyView(data.leadingContent())
  }
}
