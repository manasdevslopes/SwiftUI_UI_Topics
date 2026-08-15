//
// AnimatedButton.swift
// Animations
//
// Created by MANAS VIJAYWARGIYA on 15/08/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct AnimatedButton: View {
  let text: String
  let action: () -> Void
  
  @State private var isAnimating: Bool = false
  @State private var wipeProgress: CGFloat = 0
  
  private let duration: Double = 0.42
  
  var body: some View {
    Button {
      guard !isAnimating else { return }
      isAnimating = true
      
      withAnimation(.easeInOut(duration: duration)) {
        wipeProgress = 1
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
        action()
        
        // Reset in case this view stays visible
        wipeProgress = 0
        isAnimating = false
      }
    } label: {
      ZStack {
        RoundedRectangle(cornerRadius: 20).fill(Color.white)
        RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
        Text(text).font(.system(size: 16)).foregroundStyle(.gray)
          .padding(.vertical, 19)
          .frame(maxWidth: .infinity)
        
        ZStack {
          RoundedRectangle(cornerRadius: 20).fill(Color.blue)
          Text(text).font(.system(size: 16)).foregroundStyle(.white)
            .padding(.vertical, 19)
            .frame(maxWidth: .infinity)
        }
        .mask(alignment: .trailing) {
          GeometryReader { proxy in
            let width = proxy.size.width
            let revealed = width * wipeProgress
            let feather = min(28, revealed)
            
            HStack(spacing: 0) {
              // soft edge from transparent -> visible
              LinearGradient(colors: [Color.clear, Color.white], startPoint: .leading, endPoint: .trailing)
                .frame(width: feather)
              
              Rectangle().fill(.white).frame(width: max(0, revealed - feather))
            }
            .frame(width: revealed, alignment: .trailing)
            .frame(maxWidth: .infinity, alignment: .trailing)
          }
        }
      }
      .frame(maxWidth: .infinity)
      .frame(height: 57)
    }
    .buttonStyle(.plain)
    .padding(.horizontal, 32)
    .allowsHitTesting(!isAnimating)
  }
}

#Preview {
  AnimatedButton(text: "Animated button", action: { print("Tapped") })
}
