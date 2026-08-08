//
// NumberCountViewModel.swift
// RefreshLoop
//
// Created by MANAS VIJAYWARGIYA on 08/08/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
import SwiftUI
import Combine
import Foundation

@MainActor final class NumberCountViewModel: NSObject, ObservableObject {
  @Published var detailNumCount: NumberCount?
  @Published var previewNumCount: NumberCount?
  @Published var showPreviewOfNumCount: Bool = false
  @Published var showDetailOfNumCount: Bool = false

  @Published var numberCountRenderVersion: Int = 0

  @Published var openRandomScreen: Bool = false
  
  // Below properties for Refresh NUMBER Count Latency
  private var numberCountRefreshTask: Task<Void, Never>?
  private var numberCountRefreshID: String?
  private var numberCountRefreshInterval: Int = 10 // 10 sec

  // Computed property to decide when refreshing should be allowed
  var shouldAutoRefresh: Bool {
   (showPreviewOfNumCount || showDetailOfNumCount) && !openRandomScreen
  }
  
  var fullSheetOpenedHeight: Double {
    return UIScreen.screenHeight - CGFloat(keyWindow()?.safeAreaInsets.bottom ?? 0.0)
  }
}

extension NumberCountViewModel {
  @MainActor
  func openPreview(id: String) async {
    let numberCount = NumberCount(id: id, num: 1)
    previewNumCount = numberCount
    withAnimation(.easeInOut(duration: 0.35)) {
      showPreviewOfNumCount = true
    }
  }
  
  @MainActor
  func hidePreview() {
//    if previewNumCount != nil {
//      withAnimation { self.showPreviewOfNumCount = false }
//      previewNumCount = nil
//    }
    withAnimation(.easeInOut(duration: 0.35)) {
      showPreviewOfNumCount = false
      previewNumCount = nil
    }
  }
  
  @MainActor
  func showDetail() {
    withAnimation(.easeInOut(duration: 0.35)) {
      showDetailOfNumCount = true
    }
    updateRefreshLoopState()
  }
  
  func hideDetail() {
    withAnimation(.easeInOut(duration: 0.35)) {
      showDetailOfNumCount = false
      detailNumCount = nil
    }
    updateRefreshLoopState()
  }
}

extension NumberCountViewModel {
  // State updater and use this in every method and onAppear & onDisappear of both Preview and Detail Screens
  @MainActor
  func updateRefreshLoopState() {
    let id = detailNumCount?.id ?? previewNumCount?.id
    if shouldAutoRefresh {
      startNumberCountRefreshLoop(for: id)
    } else {
      stopNumberCountRefreshLoop()
    }
  }
  
  // Refresh Method
  @MainActor
  func refreshNumberCountOnPullToRefresh() async {
    await refreshNumberCount()
  }
  
  @MainActor
  private func refreshNumberCount() async {
    guard let id = numberCountRefreshID ?? detailNumCount?.id ?? previewNumCount?.id else { return }
    
    // Refresh logic / API call
    let newNum = Int.random(in: 1...99)
    
    if let preview = previewNumCount, preview.id == id {
      withAnimation(.bouncy) {
        previewNumCount = NumberCount(id: preview.id, num: newNum)
        print("Number changed in Preview, \(newNum)")
      }
    }
    
    if let detail = detailNumCount, detail.id == id {
      withAnimation(.bouncy) {
        detailNumCount = NumberCount(id: detail.id, num: newNum)
        print("Number changed in Detail, \(newNum)")
      }
    }
    
    numberCountRenderVersion += 1
  }
}

extension NumberCountViewModel {
  // Loop Started
  @MainActor
  private func startNumberCountRefreshLoop(for id: String?) {
    guard let id, shouldAutoRefresh else {
      stopNumberCountRefreshLoop()
      return
    }
    
    if numberCountRefreshTask != nil, numberCountRefreshID == id {
      return
    }
    
    stopNumberCountRefreshLoop()
    numberCountRefreshID = id
    
    numberCountRefreshTask = Task { [weak self] in
      guard let self else { return }
      
      while !Task.isCancelled {
        guard self.shouldAutoRefresh else {
          self.stopNumberCountRefreshLoop()
          break
        }
        
        await self.refreshNumberCount()
        try? await Task.sleep(for: .seconds(self.numberCountRefreshInterval))
      }
    }
  }
  
  // Loop stopper
  @MainActor
  private func stopNumberCountRefreshLoop() {
    numberCountRefreshTask?.cancel()
    numberCountRefreshTask = nil
    numberCountRefreshID = nil
  }
}
