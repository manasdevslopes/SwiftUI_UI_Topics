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

struct LText: View {
  @Environment(\.locale) private var locale
  
  let key: String
  let arguments: [CVarArg]
  
  init(key: String, arguments: CVarArg...) {
    self.key = key
    self.arguments = arguments
  }
  
  var body: some View {
    Text(localizedString)
  }
  
  private var localizedString: String {
    if arguments.isEmpty {
      return LocalizationManager.shared.localizedString(forKey: key, locale: locale)
    } else {
      return LocalizationManager.shared.localizedString(forKey: key, locale: locale, args: arguments)
    }
  }
}
