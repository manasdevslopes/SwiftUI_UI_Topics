//
// HighlightAnchorKey.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 26/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

/// Anchor Key
struct HighlightAnchorKey: PreferenceKey {
  static var defaultValue: [Int: Highlight] = [:]
  
  static func reduce(value: inout [Int : Highlight], nextValue: () -> [Int : Highlight]) {
    value.merge(nextValue()) { $1 }
  }
}
