//
// TimerViewModel.swift
// TimerLogic
//
// Created by MANAS VIJAYWARGIYA on 06/10/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

class TimerViewModel: ObservableObject {
  @Published var chargingTimeElapsed: Int = 0
  
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  var startTime = Date()
  
  init(_ timestamp: Int) {
    self.startTime = Date(timeIntervalSince1970: Double(timestamp / 1000))
    self.chargingTimeElapsed = Int(getElapsedTime)
  }
  
  var getElapsedTime: Double {
    return Date().timeIntervalSince(startTime)
  }
  
  var getElapsedTimeText: String {
    return "\(formateSecondsToString(getElapsedTime))"
  }
  
  private func formateSecondsToString(_ seconds: TimeInterval) -> String {
    if seconds.isNaN {
      return "00:00:00"
    }
    let Hour = Int(seconds / 3600)
    let Min = Int(seconds.truncatingRemainder(dividingBy: 3600) / 60)
    let secs = Int(seconds.truncatingRemainder(dividingBy: 60))
    return String(format: "%02d:%02d:%02d", Hour, Min, secs)
  }
}
