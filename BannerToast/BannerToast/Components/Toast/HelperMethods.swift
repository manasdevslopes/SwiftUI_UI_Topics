//
// HelperMethods.swift
// BannerToast
//
// Created by MANAS VIJAYWARGIYA on 27/11/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

// MARK: - Factory helpers to avoid repeating optional args
func makeToast(
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
) -> InlineToastData<EmptyView> {
  InlineToastData(
    type: type,
    hyperlinkText: hyperlinkText,
    placeholderText: placeholderText,
    tappableText: tappableText,
    fontSize: fontSize,
    textColor: textColor,
    linkColor: linkColor,
    showBorder: showBorder,
    onHyperlinkTap: onHyperlinkTap,
    onDismiss: onDismiss
  )
}

func makeToastWithLeading<T: View>(
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
) -> InlineToastData<T> {
  InlineToastData(
    type: type,
    hyperlinkText: hyperlinkText,
    placeholderText: placeholderText,
    tappableText: tappableText,
    fontSize: fontSize,
    textColor: textColor,
    linkColor: linkColor,
    showBorder: showBorder,
    onHyperlinkTap: onHyperlinkTap,
    onDismiss: onDismiss,
    leadingContent: leadingContent
  )
}

/// With leading content
//func makeToastWithLeading<T: View>(
//  type: InlineMessageType,
//  hyperlinkText: String? = nil,
//  placeholderText: String? = nil,
//  tappableText: String? = nil,
//  fontSize: CGFloat = 16,
//  textColor: UIColor = .darkGray,
//  linkColor: UIColor = .green,
//  showBorder: Bool = false,
//  onHyperlinkTap: (() -> Void)? = nil,
//  onDismiss: (() -> Void)? = nil,
//  @ViewBuilder leadingContent: @escaping () -> T
//) -> InlineToastData<T> {
//  InlineToastData(
//    type: type,
//    hyperlinkText: hyperlinkText,
//    placeholderText: placeholderText,
//    tappableText: tappableText,
//    fontSize: fontSize,
//    textColor: textColor,
//    linkColor: linkColor,
//    showBorder: showBorder,
//    onHyperlinkTap: onHyperlinkTap,
//    onDismiss: onDismiss,
//    leadingContent: leadingContent
//  )
//}
//
///// Without leading content (EmptyView)
//func makeToast(
//  type: InlineMessageType,
//  hyperlinkText: String? = nil,
//  placeholderText: String? = nil,
//  tappableText: String? = nil,
//  fontSize: CGFloat = 16,
//  textColor: UIColor = .darkGray,
//  linkColor: UIColor = .green,
//  showBorder: Bool = false,
//  onHyperlinkTap: (() -> Void)? = nil,
//  onDismiss: (() -> Void)? = nil
//) -> InlineToastData<EmptyView> {
//  InlineToastData(
//    type: type,
//    hyperlinkText: hyperlinkText,
//    placeholderText: placeholderText,
//    tappableText: tappableText,
//    fontSize: fontSize,
//    textColor: textColor,
//    linkColor: linkColor,
//    showBorder: showBorder,
//    onHyperlinkTap: onHyperlinkTap,
//    onDismiss: onDismiss
//  )
//}

// MARK: - Factory helpers to avoid repeating optional args

/*
/// With leading content + dismiss
func makeToastWithLeadingAndDismiss<T: View>(
  type: InlineMessageType,
  hyperlinkText: String? = nil,
  placeholderText: String? = nil,
  tappableText: String? = nil,
  fontSize: CGFloat = 16,
  textColor: UIColor = .darkGray,
  linkColor: UIColor = .green,
  showBorder: Bool = false,
  onHyperlinkTap: (() -> Void)? = nil,
  onDismiss: @escaping () -> Void,
  @ViewBuilder leadingContent: @escaping () -> T
) -> InlineToastData<T> {
  InlineToastData(
    type: type,
    hyperlinkText: hyperlinkText,
    placeholderText: placeholderText,
    tappableText: tappableText,
    fontSize: fontSize,
    textColor: textColor,
    linkColor: linkColor,
    showBorder: showBorder,
    onHyperlinkTap: onHyperlinkTap,
    onDismiss: onDismiss,
    leadingContent: leadingContent
  )
}

/// With leading content + no dismiss
func makeToastWithLeadingNoDismiss<T: View>(
  type: InlineMessageType,
  hyperlinkText: String? = nil,
  placeholderText: String? = nil,
  tappableText: String? = nil,
  fontSize: CGFloat = 16,
  textColor: UIColor = .darkGray,
  linkColor: UIColor = .green,
  showBorder: Bool = false,
  onHyperlinkTap: (() -> Void)? = nil,
  @ViewBuilder leadingContent: @escaping () -> T
) -> InlineToastData<T> {
  InlineToastData(
    type: type,
    hyperlinkText: hyperlinkText,
    placeholderText: placeholderText,
    tappableText: tappableText,
    fontSize: fontSize,
    textColor: textColor,
    linkColor: linkColor,
    showBorder: showBorder,
    onHyperlinkTap: onHyperlinkTap,
    onDismiss: nil,
    leadingContent: leadingContent
  )
}

/// Without leading content + dismiss
func makeToastNoLeadingWithDismiss(
  type: InlineMessageType,
  hyperlinkText: String? = nil,
  placeholderText: String? = nil,
  tappableText: String? = nil,
  fontSize: CGFloat = 16,
  textColor: UIColor = .darkGray,
  linkColor: UIColor = .green,
  showBorder: Bool = false,
  onHyperlinkTap: (() -> Void)? = nil,
  onDismiss: @escaping () -> Void
) -> InlineToastData<EmptyView> {
  InlineToastData(
    type: type,
    hyperlinkText: hyperlinkText,
    placeholderText: placeholderText,
    tappableText: tappableText,
    fontSize: fontSize,
    textColor: textColor,
    linkColor: linkColor,
    showBorder: showBorder,
    onHyperlinkTap: onHyperlinkTap,
    onDismiss: onDismiss,
    leadingContent: { EmptyView() }
  )
}

/// Without leading content (EmptyView) + no dismiss
/// Without leading content
func makeToastNoLeadingNoDismiss(
  type: InlineMessageType,
  hyperlinkText: String? = nil,
  placeholderText: String? = nil,
  tappableText: String? = nil,
  fontSize: CGFloat = 16,
  textColor: UIColor = .darkGray,
  linkColor: UIColor = .green,
  showBorder: Bool = false,
  onHyperlinkTap: (() -> Void)? = nil
) -> InlineToastData<EmptyView> {
  
  InlineToastData(
    type: type,
    hyperlinkText: hyperlinkText,
    placeholderText: placeholderText,
    tappableText: tappableText,
    fontSize: fontSize,
    textColor: textColor,
    linkColor: linkColor,
    showBorder: showBorder,
    onHyperlinkTap: onHyperlinkTap,
    onDismiss: nil
  )
}
*/
