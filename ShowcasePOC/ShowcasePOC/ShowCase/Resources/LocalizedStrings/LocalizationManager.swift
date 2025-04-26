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
  func localizedString(forKey key: String) -> String {
    let notFoundString = "--------NOTFOUND--------"
    
    let bundle = Bundle.main
    
    // Check in Scheme.xcstrings
    let string = bundle.localizedString(forKey: key, value: notFoundString, table: "Scheme")
    if string != notFoundString {
      return string
    }
    
    // Check in Localizable.xcstrings
    let commonString = bundle.localizedString(forKey: key, value: notFoundString, table: nil)
    if commonString != notFoundString {
      return commonString
    }
    
    // If not found in any, return the key itself
    return key
  }
}
