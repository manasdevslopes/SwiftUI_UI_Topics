//
// HapticManager.swift
// HapticEvents
//
// Created by MANAS VIJAYWARGIYA on 07/12/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
import SwiftUI
import CoreHaptics
import Combine

@MainActor
final class HapticManager: ObservableObject {
  
  static let shared = HapticManager()
  
  private var engine: CHHapticEngine?
  private var cancellables = Set<AnyCancellable>()
  
  private init() {
    observeAppLifecycle()
    prepareHaptics()
  }
  
  // MARK: - Lifecycle Handling
  
  private func observeAppLifecycle() {
    NotificationCenter.default
      .publisher(for: UIApplication.willEnterForegroundNotification)
      .sink { [weak self] _ in
        self?.prepareHaptics()
      }
      .store(in: &cancellables)
    
    NotificationCenter.default
      .publisher(for: UIApplication.didEnterBackgroundNotification)
      .sink { [weak self] _ in
        self?.engine?.stop(completionHandler: nil)
      }
      .store(in: &cancellables)
  }
  
  // MARK: - Engine Setup
  
  func prepareHaptics() {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    
    do {
      engine = try CHHapticEngine()
      try engine?.start()
    } catch {
      print("Haptic engine error:", error.localizedDescription)
    }
  }
  
  // MARK: - Simple Core Haptic
  
  func playSimpleSuccess() {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    
    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
    
    let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
    
    play(events: [event])
  }
  
  // MARK: - Complex Ramp Up & Down
  
  func playComplexWave() {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    
    var events = [CHHapticEvent]()
    
    for i in stride(from: 0, to: 1, by: 0.1) {
      let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
      let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
      
      let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
      
      events.append(event)
    }
    
    for i in stride(from: 0, to: 1, by: 0.1) {
      let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
      let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
      
      let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
      
      events.append(event)
    }
    
    play(events: events)
  }
  
  // MARK: - Engine Player
  
  private func play(events: [CHHapticEvent]) {
    do {
      let pattern = try CHHapticPattern(events: events, parameters: [])
      let player = try engine?.makePlayer(with: pattern)
      try player?.start(atTime: 0)
    } catch {
      print("Failed to play pattern:", error.localizedDescription)
    }
  }
}
