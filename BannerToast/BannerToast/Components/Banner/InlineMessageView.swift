//
// InlineMessageView.swift
// BannerToast
//
// Created by MANAS VIJAYWARGIYA on 27/11/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct InlineMessageView<T: View>: View {
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
  
  private let leadingContent: T
  private let hasLeadingContent: Bool
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
    @ViewBuilder leadingContent: @escaping () -> T,
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
    self.leadingContent = leadingContent()
    self.hasLeadingContent = true
  }
  
  // MARK: - Convenience initializer when no leading content is desired
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
  ) where T == EmptyView {
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
    self.leadingContent = EmptyView()
    self.hasLeadingContent = false
  }
  
  @State private var textHeight: CGFloat = .zero
  
  var body: some View {
    HStack(alignment: .top) {
      if hasLeadingContent {
        leadingContent.frame(width: 24, height: 24, alignment: .center)
      }
      
      // With / without hyperlink use this only
      HyperLinkedTextLabel(
        fullTextKey: hyperlinkText ?? "",
        placeholders: [placeholderText ?? ""],
        tappableTextKeys: [tappableText ?? ""],
        fontSize: fontSize,
        textColor: textColor,
        linkColor: linkColor,
        dynamicHeight: $textHeight) { _, _ in
          onHyperlinkTap?()
        }
        .frame(height: textHeight)
        .padding(.leading, 8).padding(.trailing, 8)
      
      Spacer()
      
      if let onDismiss {
        VStack {
          Image(systemName: "xmark").resizable().frame(width: 10, height: 10).foregroundStyle(.primary)
        }
        .frame(width: 24, height: 24).contentShape(.rect)
        .onTapGesture { onDismiss() }
      }
    }
    .padding(.leading, 12).padding(.trailing, 20).padding(.vertical, 8)
    .background(type.color)
    .if(showBorder) {
      $0.overlay {
        RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(type.strokeColor, lineWidth: 1)
      }
    }
    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
  }
}

#Preview {
  ZStack {
    Color.secondary.opacity(0.4).ignoresSafeArea()
    VStack(spacing: 20) {
      InlineMessageView(type: .success, hyperlinkText: "To start charging, enable notifications: Settings -> Notifications -> Fuel & Charge -> Allow Notifications", showBorder: true, leadingContent: {
        Image(systemName: "checkmark.seal.fill").resizable().frame(width: 24, height: 24)
      })
      
      InlineMessageView(type: .info, hyperlinkText: "To start charging, enable notifications: Settings -> Notifications -> Fuel & Charge -> Allow Notifications", showBorder: true, leadingContent: {
        Image(systemName: "info.circle.fill").resizable().frame(width: 24, height: 24)
      })
      
      InlineMessageView(type: .warning, hyperlinkText: "To start charging, enable notifications: Settings -> Notifications -> Fuel & Charge -> Allow Notifications. ${please_click_here}", placeholderText: "${please_click_here}", tappableText: "Please click here", showBorder: true) {
        print("Hyperlinked text tapped")
      } onDismiss: {
        print("Dismiss tapped")
      } leadingContent: {
        Image(systemName: "exclamationmark.triangle.fill").resizable().frame(width: 24, height: 24)
      }
      
      InlineMessageView(type: .error, hyperlinkText: "To start charging, enable notifications: Settings -> Notifications -> Fuel & Charge -> Allow Notifications. ${please_click_here}", placeholderText: "${please_click_here}", tappableText: "Please click here", showBorder: true) {
        print("Hyperlinked text tapped")
      } onDismiss: {
        print("Dismiss tapped")
      } leadingContent: {
        Image(systemName: "questionmark.folder").resizable().frame(width: 24, height: 24)
      }
      
      InlineMessageView(type: .neutral, hyperlinkText: "To start charging, enable notifications: Settings -> Notifications -> Fuel & Charge -> Allow Notifications. ${please_click_here}", placeholderText: "${please_click_here}", tappableText: "Please click here", showBorder: true) {
        print("Hyperlinked text tapped")
      } onDismiss: {
        print("Dismiss tapped")
      } leadingContent: {
        Image(systemName: "receipt").resizable().frame(width: 24, height: 24)
      }
    }
    .padding(4)
  }
}
