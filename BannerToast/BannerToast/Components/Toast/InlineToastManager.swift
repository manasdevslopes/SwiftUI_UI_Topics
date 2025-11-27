//
// InlineToastManager.swift
// BannerToast
//
// Created by MANAS VIJAYWARGIYA on 27/11/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import Observation
import SwiftUI

@Observable
final class InlineToastManager {
  static let shared = InlineToastManager()
  
  var alignment: VerticalAlignment = .bottom
  var toastType: ToastType = .scaleToast
  var isPresented: Bool = false
  var data: AnyInlineToastData?
  private var dismissWorkItem: DispatchWorkItem?
  
  func show<T: View>(alignment: VerticalAlignment = .bottom, toastType: ToastType = .scaleToast, _ data: InlineToastData<T>, duration: Double = 5) {
    // Cancel any existing timer
    dismissWorkItem?.cancel()
    
    self.alignment = alignment
    self.toastType = toastType
    self.data = AnyInlineToastData(data)
    withAnimation(.spring()) { isPresented = true }
    
    // Create a new dismiss task
    let workItem = DispatchWorkItem {[weak self] in
      self?.hide()
    }
    dismissWorkItem = workItem
    
    DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: workItem)
  }
  
  func hide() {
    // Cancel any future scheduled hide
    dismissWorkItem?.cancel()
    dismissWorkItem = nil
    
    withAnimation { isPresented = false }
    data?.onDismiss?()
  }
}
