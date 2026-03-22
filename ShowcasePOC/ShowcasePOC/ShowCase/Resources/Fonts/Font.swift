//
// Font.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 22/03/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

var isAralScheme = false

// MARK: - ShantellSans Fonts
enum ShantellSansFont: String {
case regular = "ShantellSans-Regular"
case italic = "ShantellSans-Italic"
case light = "ShantellSans-Light"
case lightItalic = "ShantellSans-LightItalic"
case medium = "ShantellSans-Medium"
case mediumItalic = "ShantellSans-MediumItalic"
case bold = "ShantellSans-Bold"
case boldItalic = "ShantellSans-BoldItalic"
case semiBold = "ShantellSans-SemiBold"
case semiBoldItalic = "ShantellSans-SemiBoldItalic"
case extraBold = "ShantellSans-ExtraBold"
case extraBoldItalic = "ShantellSans-ExtraBoldItalic"
}

// MARK: - Corinthia Fonts
enum CorinthiaFont: String {
  case bold = "Corinthia-Bold"
  case regular = "Corinthia-Regular"
}

enum AppFont {
  static func shantellSans(_ font: ShantellSansFont, size: CGFloat) -> Font {
    Font.custom(font.rawValue, size: size)
  }
  
  static func corinthia(_ font: CorinthiaFont, size: CGFloat) -> Font {
    Font.custom(font.rawValue, size: size)
  }
  
  static func font(shantellSans: ShantellSansFont, corinthia: CorinthiaFont, size: CGFloat) -> Font {
    Font.custom(isAralScheme ? corinthia.rawValue : shantellSans.rawValue, size: size)
  }
}
