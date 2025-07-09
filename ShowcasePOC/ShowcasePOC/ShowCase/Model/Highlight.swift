//
// Highlight.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 26/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct Highlight: Identifiable, Equatable {
  var id: UUID = .init()
  var anchor: Anchor<CGRect>
  var step: TutorialStep
  var cornerRadius: CGFloat
  var style: RoundedCornerStyle = .continuous
  var scale: CGFloat = 1
}
