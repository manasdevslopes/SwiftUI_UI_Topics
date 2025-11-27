//
// GlobalInlineToastModifier.swift
// BannerToast
//
// Created by MANAS VIJAYWARGIYA on 27/11/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

enum ToastType: String, Equatable, CaseIterable {
  case scaleToast = "scaleToast"
  case offsetToast = "offsetToast"
}

struct GlobalInlineToastModifier: ViewModifier {
  @Bindable var manager = InlineToastManager.shared
  
  var scaleToast: some View {
    VStack {
      if manager.alignment == .bottom {
        Spacer()
      }
      
      if let data = manager.data {
        InlineMessageView(
          type: data.type,
          hyperlinkText: data.hyperlinkText,
          placeholderText: data.placeholderText,
          tappableText: data.tappableText,
          fontSize: data.fontSize,
          textColor: data.textColor,
          linkColor: data.linkColor,
          showBorder: data.showBorder,
          onHyperlinkTap: data.onHyperlinkTap) {
            manager.hide()
          } leadingContent: {
            data.leadingContent
          }
          .padding(.horizontal, 4)
      }
      
      if manager.alignment == .top {
        Spacer()
      }
    }
    .opacity(manager.isPresented ? 1 : 0)
    .scaleEffect(manager.isPresented ? 1 : 0)
    .animation(.easeOut, value: manager.isPresented)
  }
  
  var offsetToast: some View {
    VStack {
      if manager.alignment == .bottom {
        Spacer()
      }
      
      if let data = manager.data {
        InlineMessageView(
          type: data.type,
          hyperlinkText: data.hyperlinkText,
          placeholderText: data.placeholderText,
          tappableText: data.tappableText,
          fontSize: data.fontSize,
          textColor: data.textColor,
          linkColor: data.linkColor,
          showBorder: data.showBorder,
          onHyperlinkTap: data.onHyperlinkTap) {
            manager.hide()
          } leadingContent: {
            data.leadingContent
          }
          .padding(.horizontal, 4)
      }
      
      if manager.alignment == .top {
        Spacer()
      }
    }
    .opacity(manager.isPresented ? 1 : 0)
    .offset(x: 0, y: manager.isPresented ? manager.alignment == .bottom ? 0 : 0 : manager.alignment == .bottom ? 70 : -100)
    .animation(.easeOut, value: manager.isPresented)
  }
  
  private var toastView: AnyView {
    if manager.toastType == .offsetToast {
      return AnyView(offsetToast)
    } else {
      return AnyView(scaleToast)
    }
  }
  
  func body(content: Content) -> some View {
    ZStack {
      content
      
      toastView
        .gesture(
          DragGesture().onEnded { value in
            if abs(value.translation.height) > 20 {
              manager.hide()
            }
          }
        )
    }
  }
}

extension View {
  func globalInlineToast() -> some View {
    self.modifier(GlobalInlineToastModifier())
  }
}
