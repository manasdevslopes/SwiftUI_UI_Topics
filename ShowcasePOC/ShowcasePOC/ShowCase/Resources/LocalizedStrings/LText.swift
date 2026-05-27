//
// LText.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 22/03/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
import SwiftUI

enum LTextArg {
  case string(CVarArg)
  case timestamp(Double)
  case localizedNumber(Double, decimals: Int)
}

struct LText: View {
  @Environment(\.locale) private var locale
  
  let key: String
  let resolvedArgs: [LTextArg]
  
  // Plain text, no args
  init(_ key: String) {
    self.key = key
    self.resolvedArgs = []
  }
  
  // String / number args only
  init(_ key: String, args arguments: CVarArg...) {
    self.key = key
    self.resolvedArgs = arguments.map { .string($0) }
  }
  
  // Mixed args: timestamp + any other (string, int, double etc) in correct order
  init(_ key: String, mixedArgs: [LTextArg]) {
    self.key = key
    self.resolvedArgs = mixedArgs
  }
  
  var body: some View {
    Text(localizedString)
  }
  
  private var localizedString: String {
    if resolvedArgs.isEmpty {
      return LocalizationManager.shared.localizedString(forKey: key, locale: locale)
    }
    
    let formatted: [CVarArg] = resolvedArgs.map { arg in
      switch arg {
        case .string(let value): return value
        case .timestamp(let value):
          return LocaleHelper.formatTimeStamp(value, locale: locale) ?? "" as CVarArg
        case .localizedNumber(let value, let decimal):
          return LocaleHelper.numberFormatted(value, decimals: decimal, locale: locale) ?? "" as CVarArg
      }
    }
    
    return LocalizationManager.shared.localizedString(forKey: key, locale: locale, args: formatted)
    
  }
}
