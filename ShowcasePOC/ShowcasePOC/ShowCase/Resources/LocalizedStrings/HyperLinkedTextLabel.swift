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
  // MARK: - Pass localization keys instead of localized strings
  var fullTextKey: String
  var placeholders: [String]
  var tappableTextKeys: [String]
  var fontSize: CGFloat
  var textColor: UIColor
  var linkColor: UIColor
  @Binding var dynamicHeight: CGFloat
  var onTap: (Int, String) -> Void
  
  func makeUIView(context: Context) -> UITextView {
    let textView = UITextView()
    textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    textView.isEditable = false
    textView.isSelectable = true
    textView.isScrollEnabled = false
    textView.delegate = context.coordinator
    textView.textContainer.lineFragmentPadding = 0
    textView.textContainerInset = .zero
    textView.textAlignment = .left
    textView.backgroundColor = .clear
    textView.linkTextAttributes = [
      .foregroundColor: linkColor,
      .underlineStyle: NSUnderlineStyle.single.rawValue,
      .underlineColor: linkColor
    ]
    
    return textView
  }
  
  func updateUIView(_ uiTextView: UITextView, context: Context) {
    // Localize the main text and tappable texts automatically
    let localizedFullText = LocalizationManager.shared.localizedString(forKey: fullTextKey)
    let localizedTappableTexts = tappableTextKeys.map { LocalizationManager.shared.localizedString(forKey: $0) }
    
    // Replace placeholders with tappable texts
    var fullText = localizedFullText
    for (index, placeholder) in placeholders.enumerated() where index < localizedTappableTexts.count {
      fullText = fullText.replacingOccurrences(of: placeholder, with: localizedTappableTexts[index])
    }
    
    // Base style
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4
    paragraphStyle.alignment = .left
    paragraphStyle.lineBreakMode = .byWordWrapping
    
    let baseAttributes: [NSAttributedString.Key: Any] = [
      .font: UIFont.systemFont(ofSize: fontSize),
      .foregroundColor: textColor,
      .paragraphStyle: paragraphStyle
    ]
    
    let attributed = NSMutableAttributedString(string: fullText, attributes: baseAttributes)
    
    // Style each tappable text with green + underline + own unique link
    for (index, tappable) in localizedTappableTexts.enumerated() {
      let range = (fullText as NSString).range(of: tappable)
      if range.location != NSNotFound {
        attributed.addAttributes([
          // Create some kind of deeplink URL so that which one was tapped
          .link: "action://\(index)",
          .foregroundColor: linkColor,
          .underlineStyle: NSUnderlineStyle.single.rawValue,
          .underlineColor: linkColor
        ], range: range)
      }
    }
    
    // Measure and update height dynamically
    DispatchQueue.main.async {
      // Ensure layout has a valid width
      uiTextView.attributedText = attributed
      uiTextView.layoutIfNeeded()
      
      let fittingWidth = uiTextView.bounds.width > 0 ? uiTextView.bounds.width : UIScreen.main.bounds.width - 80
      let newSize = uiTextView.sizeThatFits(CGSize(width: fittingWidth, height: .greatestFiniteMagnitude))
      if abs(self.dynamicHeight - newSize.height) > 1 {
        self.dynamicHeight = newSize.height
      }
    }
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
    // MARK: - iOS 16 and below (deprecated in iOS 17)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, /*interaction: UITextItemInteraction*/) -> Bool {
      // URL format: "action://0", "action://1", etc.
      if URL.scheme == "action", let index = Int(URL.host ?? "") {
        if index < parent.tappableTextKeys.count {
          let tappedText = LocalizationManager.shared.localizedString(forKey: parent.tappableTextKeys[index])
          parent.onTap(index, tappedText)
        }
        return false
      }
      return true
    }
  }
}
