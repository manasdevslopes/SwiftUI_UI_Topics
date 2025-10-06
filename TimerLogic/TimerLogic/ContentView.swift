//
// ContentView.swift
// TimerLogic
//
// Created by MANAS VIJAYWARGIYA on 06/10/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct ContentView: View {
  @StateObject private var timerVM: TimerViewModel = TimerViewModel(0)
  @State private var isTimerRunning = false
  
  @AppStorage("startTimestamp") private var startTimestamp: Int?
  
  var body: some View {
    VStack(spacing: 20) {
      if isTimerRunning {
        Text("Elapsed Time: \(timerVM.getElapsedTimeText)").font(.title2)
          .onReceive(timerVM.timer) { _ in
            timerVM.chargingTimeElapsed += 1
          }
      } else {
        Text("Press Start to begin timer").foregroundColor(.gray)
      }
      
      Button {
        if isTimerRunning {
          // Stop timer
          isTimerRunning = false
          startTimestamp = nil // clear AppStorage
        } else {
          // Start timer
          let timestamp: Int
          if let savedTimestamp = startTimestamp {
            timestamp = savedTimestamp
          } else {
            timestamp = Int(Date().timeIntervalSince1970 * 1000)
            startTimestamp = timestamp // save to AppStorage
          }
          
          timerVM.startTime = Date(timeIntervalSince1970: Double(timestamp) / 1000)
          isTimerRunning = true
        }
      } label: {
        Text(isTimerRunning ? "Stop Timer" : "Start Timer")
          .fontWeight(.semibold).padding()
          .frame(maxWidth: .infinity)
          .background(isTimerRunning ? Color.red : Color.blue)
          .foregroundColor(.white).cornerRadius(12)
          .animation(.easeInOut(duration: 0.2), value: isTimerRunning)
      }
      .padding(.horizontal)
    }
    .padding()
    .onAppear {
      // Check AppStorage on launch
      if let savedTimestamp = startTimestamp {
        timerVM.startTime = Date(timeIntervalSince1970: Double(savedTimestamp) / 1000)
        isTimerRunning = true
      }
    }
    .onDisappear {
      timerVM.timer.upstream.connect().cancel()
    }
  }
}

#Preview {
  ContentView()
}
