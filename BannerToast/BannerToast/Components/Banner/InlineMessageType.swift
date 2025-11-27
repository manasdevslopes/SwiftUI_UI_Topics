//
// InlineMessageType.swift
// BannerToast
//
// Created by MANAS VIJAYWARGIYA on 27/11/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

enum InlineMessageType {
  case neutral
  case success
  case info
  case warning
  case error
}

extension InlineMessageType {
  var color: Color {
    switch self {
      case .neutral: return .white
      case .success: return .green
      case .info: return .blue
      case .warning: return .orange
      case .error: return .red
    }
  }
  
  var strokeColor: Color {
    switch self {
      case .neutral: return .cyan
      case .success: return .teal
      case .info: return .purple
      case .warning: return .mint
      case .error: return .pink
    }
  }
}
