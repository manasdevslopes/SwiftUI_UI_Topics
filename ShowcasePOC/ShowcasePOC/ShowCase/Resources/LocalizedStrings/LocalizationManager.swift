//
// LocalizationManager.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 26/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

class LocalizationManager {
  static let shared = LocalizationManager()
  
  private init() {}
  
  /// Fetches a localized string by searching in the following order:
  /// 1. Scheme.xcstrings
  /// 2. Localizable.xcstrings
  /// If the key is not found in any of these, it returns the key itself.
  func localizedString(forKey key: String, locale: Locale = .current) -> String {
    
    let notFoundString = "--------NOTFOUND--------"
    
    let languageCode = locale.language.languageCode?.identifier ?? "en"
    
    let bundle: Bundle
    
    if let path = Bundle.main.path(forResource: locale.identifier, ofType: "lproj"), let langBundle = Bundle(path: path) {
      bundle = langBundle
    } else if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let langBundle = Bundle(path: path) {
      bundle = langBundle
    } else {
      bundle = .main
    }

    // Check in Scheme.xcstrings
    let scheme = bundle.localizedString(forKey: key, value: notFoundString, table: "Scheme")
    if scheme != notFoundString {
      return scheme
    }
    
    // Check in Localizable.xcstrings
    let commonString = bundle.localizedString(forKey: key, value: notFoundString, table: nil)
    if commonString != notFoundString {
      return commonString
    }
    
    // If not found in any, return the key itself
    return key
  }
  
  /// Fetch localized string with arguments (like %lld, %@ etc.)
  func localizedString(forKey key: String, locale: Locale = .current, args arguments: CVarArg...) -> String {
    let format = localizedString(forKey: key, locale: locale)
    return String(format: format, locale: locale, arguments: arguments)
  }
}

extension Locale {
  
  // English
  static let en = Locale(identifier: "en")
  
  // German
  static let de = Locale(identifier: "de")
  
}
