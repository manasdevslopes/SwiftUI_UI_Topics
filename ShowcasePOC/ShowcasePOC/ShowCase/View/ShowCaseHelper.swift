//
// ShowCaseHelper.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 26/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

/// ShowCase Root View Modifier
struct ShowCaseRoot: ViewModifier {
  var showHighlights: Bool
  var onFinished: () -> ()
  
  // View Properties
  @State private var highlightOrder: [Int] = []
  @State private var currentHighlight: Int = 0
  @State private var showView: Bool = true
  
  // Popover
  @State private var showTitle: Bool = false
  @State private var isMenuShowcaseComplete: Bool = false
  @State private var menuOpened: Bool = false
  @EnvironmentObject var primeViewModel: PrimeViewModel

  // Namespace ID, for Smooth Shape Transition
  @Namespace private var animation
  
  func body(content: Content) -> some View {
    content
      .onPreferenceChange(HighlightAnchorKey.self) { value in
        highlightOrder = Array(value.keys).sorted()
      }
      .overlayPreferenceValue(HighlightAnchorKey.self) { preferences in
        if highlightOrder.indices.contains(currentHighlight), showHighlights, showView {
          if let highlight = preferences[highlightOrder[currentHighlight]] {
            if menuOpened && currentHighlight == 8 {
              HighlightView(highlight)
            } else {
              HighlightView(highlight)
            }
          }
        }
      }
  }
  
  /// Highlight View
  @ViewBuilder
  func HighlightView(_ highlight: Highlight) -> some View {
    /// Geometry Reader for Extracting Highlight Frame Rects
    GeometryReader { proxy in
      let highlightRect = proxy[highlight.anchor]
      let safeArea = proxy.safeAreaInsets
      
      Rectangle().fill(.black.opacity(0.6))
        .reverseMask {
          Rectangle()
            .matchedGeometryEffect(id: "HIGHLIGHTSHAPE", in: animation)
          // Adding Border. Simply Extend it's Size
            .frame(width: highlightRect.width + 5, height: highlightRect.height + 5)
            .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
            .scaleEffect(highlight.scale)
            .offset(x: highlightRect.minX - 2.5, y: highlightRect.minY + safeArea.top - 2.5)
        }
        // .allowsHitTesting(false)
        .ignoresSafeArea()
        .onAppear { showTitle = true }
        .onTapGesture { showTitle.toggle() }
        .onChange(of: currentHighlight) { oldValue, newValue in
          if newValue == 9 {
            toggleShowTitle(withDelay: 0.1, to: false)
            toggleShowTitle(withDelay: 0.5, to: true)
          }
        }
      
      Rectangle().foregroundStyle(.clear)
      // Adding Border. Simply Extend it's Size
        .frame(width: highlightRect.width + 20, height: highlightRect.height + 20)
        .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
        .popover(isPresented: $showTitle) {
          HighlightPopoverContent(highlight: highlight) {
            print("Skipped")
            showView = false
            onFinished()
          } onNext: {
            if currentHighlight == 8 {
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                primeViewModel.showMenu()
                isMenuShowcaseComplete = true
                menuOpened = true
              }
            }
            
            if currentHighlight >= highlightOrder.count - 1 && isMenuShowcaseComplete {
              /// Hiding the highlight view, as it is the last one.
              withAnimation(.easeInOut(duration: 0.25)) {
                showView = false
                onFinished()
              }
            } else {
              /// Moving to Next Highlight
              withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.7)) {
                currentHighlight += 1
              }
            }
          }
        }
        .scaleEffect(highlight.scale)
        .offset(x: highlightRect.minX - 10, y: highlightRect.minY - 10)
    }
  }
}


extension ShowCaseRoot {
  private func toggleShowTitle(withDelay delay: Double, to value: Bool) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
      withAnimation {
        showTitle = value
      }
    }
  }
}
