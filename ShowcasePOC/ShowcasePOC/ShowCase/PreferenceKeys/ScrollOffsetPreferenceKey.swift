//
// ScrollOffsetPreferenceKey.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 03/05/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    
import Foundation
import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
  typealias Value = CGPoint
  static var defaultValue: CGPoint = .zero
  
  static func reduce(value _: inout CGPoint, nextValue _: () -> CGPoint) { }
}
