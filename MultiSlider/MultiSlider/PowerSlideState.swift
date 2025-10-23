//
// PowerSlideState.swift
// MultiSlider
//
// Created by MANAS VIJAYWARGIYA on 23/10/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import Foundation

enum PowerSlideState: Float, CaseIterable {
  case all = 0
  case three = 3.7
  case eleven = 11
  case twentyTwo = 22
  case fourtyThree = 43
  case hundredFifty = 150
  case threeHundred = 300
  case thousand = 1000
  
  var name: String {
    switch self {
      case .all: return "All"
      case .three, .eleven, .twentyTwo, .fourtyThree, .hundredFifty, .threeHundred:
        return String(Int(self.rawValue))
      case .thousand:
        return String(Int(self.rawValue)) + "+"
    }
  }
  
  var principalName: String {
    switch self {
      case .all: return "Fast"
      case .three, .eleven, .twentyTwo, .threeHundred: return ""
      case .fourtyThree: return "Rapid"
      case .hundredFifty: return "Ultra-Fast"
      case .thousand: return "Megawatt"
    }
  }
  
  var percent: Double {
    switch self {
      case .all:
        return 0
      case .three:
        return 10
      case .eleven:
        return 20
      case .twentyTwo:
        return 30
      case .fourtyThree:
        return 40
      case .hundredFifty:
        return 60
      case .threeHundred:
        return 75
      case .thousand:
        return 97
    }
  }
}
