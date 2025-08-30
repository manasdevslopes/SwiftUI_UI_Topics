//
// HyperLinkedTextLabel.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 30/08/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    
import SwiftUI
import UIKit

struct HyperLinkedTextLabel: UIViewRepresentable {
  
  var fullTextKey: String
  var placeholder: String
  var tappableText: String
  var fontSize: CGFloat
  var textColor: UIColor
  var linkColor: UIColor
  var onTap: (String) -> Void
  
  func makeUIView(context: Context) -> UITextView {
    let textView = UITextView()
    textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    textView.isEditable = false
    textView.isSelectable = true
    textView.isScrollEnabled = false
    textView.delegate = context.coordinator
    textView.textContainer.lineFragmentPadding = 0
    textView.backgroundColor = .clear
    textView.linkTextAttributes = [
      .foregroundColor: linkColor,
      .underlineStyle: NSUnderlineStyle.single.rawValue,
      .underlineColor: linkColor
    ]
    
    return textView
  }
  
  func updateUIView(_ uiTextView: UITextView, context: Context) {
    let fullTextTemplate = fullTextKey
    // 1. Replace placeholder with tappable text
    let fullText = fullTextTemplate.replacingOccurrences(of: placeholder, with: tappableText)
    
    // 2. Base style for all text
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4
    
    let baseAttributes: [NSAttributedString.Key: Any] = [
      .font: UIFont.systemFont(ofSize: fontSize),
      .foregroundColor: textColor,
      .paragraphStyle: paragraphStyle
    ]
    
    let attributed = NSMutableAttributedString(string: fullText, attributes: baseAttributes)
    
    // 3. Style tappable text with green + underline + link
    let range = (fullText as NSString).range(of: tappableText)
    if range.location != NSNotFound {
      attributed.addAttributes([
        .link: "https://\(tappableText.replacingOccurrences(of: " ", with: "_"))",
        .foregroundColor: linkColor,
        .underlineStyle: NSUnderlineStyle.single.rawValue,
        .underlineColor: linkColor
      ], range: range)
    }
    
    uiTextView.attributedText = attributed
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, UITextViewDelegate {
    let parent: HyperLinkedTextLabel
    
    init(_ parent: HyperLinkedTextLabel) {
      self.parent = parent
    }
    
    // MARK: - Shared link handling logic
    private func handleLink(_ url: URL) -> Bool {
      let linkText = url.absoluteString.replacingOccurrences(of: "https://", with: "")
      if parent.tappableText.replacingOccurrences(of: " ", with: "_") == linkText {
        parent.onTap(parent.tappableText)
        return false   // prevent system default handling
      }
      return true
    }
    
    // MARK: - iOS 16 and below (deprecated in iOS 17)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, /*interaction: UITextItemInteraction*/) -> Bool {
      return handleLink(URL)
    }
  }
}
