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
  @Environment(\.locale) private var locale
  
  // MARK: - Pass localization keys instead of localized strings
  var fullTextKey: String
  var placeholders: [String]
  var tappableTextKeys: [String]
  var fontSize: CGFloat
  var textColor: UIColor
  var linkColor: UIColor
  var textAlignment: NSTextAlignment = .left

  // MARK: - Fonts Configurations
  var baseTextShantellSans: ShantellSansFont?
  var baseTextCorinthiaFont: CorinthiaFont?
  var tappableTextShantellSans: ShantellSansFont?
  var tappableTextCorinthiaFont: CorinthiaFont?
  
  @Binding var dynamicHeight: CGFloat
  var onTap: (Int, String) -> Void
  
  // MARK: - Helper function to get UIFont
  private func getUIFont(shantellSansFont: ShantellSansFont?, corinthiaFont: CorinthiaFont?, size: CGFloat) -> UIFont {
    if isAralScheme {
      // Use Corinthia
      if let corinthia = corinthiaFont, let font = UIFont(name: corinthia.rawValue, size: size) {
        return font
      }
    } else {
      // Use ShantellSans
      if let shantell = shantellSansFont, let font = UIFont(name: shantell.rawValue, size: size) {
        return font
      }
    }
    
    // Fallback
    return UIFont.systemFont(ofSize: size)
  }
  
  func makeUIView(context: Context) -> UITextView {
    let textView = UITextView()
    textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    textView.isEditable = false
    textView.isSelectable = true
    textView.isScrollEnabled = false
    textView.dataDetectorTypes = []
    textView.isUserInteractionEnabled = true
    textView.delegate = context.coordinator
    textView.textContainer.lineFragmentPadding = 0
    textView.textContainerInset = .zero
    textView.textAlignment = textAlignment
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
    let localizedFullText = LocalizationManager.shared.localizedString(forKey: fullTextKey, locale: locale)
    let localizedTappableTexts = tappableTextKeys.map { LocalizationManager.shared.localizedString(forKey: $0, locale: locale) }
    
    // Replace placeholders with tappable texts
    var fullText = localizedFullText
    for (index, placeholder) in placeholders.enumerated() where index < localizedTappableTexts.count {
      fullText = fullText.replacingOccurrences(of: placeholder, with: localizedTappableTexts[index])
    }
    
    // Base style
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4
    paragraphStyle.alignment = textAlignment
    paragraphStyle.lineBreakMode = .byWordWrapping
    
    let baseTextFont = getUIFont(shantellSansFont: baseTextShantellSans, corinthiaFont: baseTextCorinthiaFont, size: fontSize)
    let baseAttributes: [NSAttributedString.Key: Any] = [
      .font: baseTextFont,
      .foregroundColor: textColor,
      .paragraphStyle: paragraphStyle
    ]
    
    let attributed = NSMutableAttributedString(string: fullText, attributes: baseAttributes)
    
    let tappableTextFont = getUIFont(shantellSansFont: tappableTextShantellSans, corinthiaFont: tappableTextCorinthiaFont, size: fontSize)
    
    // Style each tappable text with green + underline + own unique link
    for (index, tappable) in localizedTappableTexts.enumerated() {
      let range = (fullText as NSString).range(of: tappable)
      if range.location != NSNotFound {
        attributed.addAttributes([
          // Create some kind of deeplink URL so that which one was tapped
          .link: "action://\(index)",
          .font: tappableTextFont,
          .foregroundColor: linkColor,
          .underlineStyle: NSUnderlineStyle.single.rawValue,
          .underlineColor: linkColor
        ], range: range)
      }
    }
    
    // Update text alignment if needed
    uiTextView.textAlignment = textAlignment
    
    uiTextView.attributedText = attributed
    
    // Measure and update height dynamically
    DispatchQueue.main.async {
      // Ensure layout has a valid width
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
      return handleURLInteraction(URL)
    }
    
    private func handleURLInteraction(_ url: URL) -> Bool {
      // URL format: "action://0", "action://1", etc.
      if url.scheme == "action", let index = Int(url.host ?? "") {
        if index < parent.tappableTextKeys.count {
          let tappedText = LocalizationManager.shared.localizedString(forKey: parent.tappableTextKeys[index], locale: parent.locale)
          parent.onTap(index, tappedText)
        }
        return false
      }
      return true
    }
  }
}
