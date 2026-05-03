//
// ReadlableScrollView.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 03/05/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//

import SwiftUI

struct ReadlableScrollView<Content: View>: View {
  let axes: Axis.Set
  let showIndicators: Bool
  let offsetChanged: (CGPoint) -> ()
  let content: Content
  let id = 0
  init(axes: Axis.Set = .vertical, showIndicators: Bool = true, offsetChanged: @escaping (CGPoint) -> () = { _ in},
       @ViewBuilder content: () -> Content) {
    self.axes = axes
    self.showIndicators = showIndicators
    self.offsetChanged = offsetChanged
    self.content = content()
  }
  
  var body: some View {
    ScrollView(axes, showsIndicators: showIndicators) {
      GeometryReader { geo in
        Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .named("scrollView")).origin)
      }.frame(width: 0, height: 0).id(id)
      content
    }
    .coordinateSpace(NamedCoordinateSpace.named("scrollView"))
    .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
  }
}
