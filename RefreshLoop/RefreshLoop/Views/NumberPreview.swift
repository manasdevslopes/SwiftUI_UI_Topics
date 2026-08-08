//
// NumberPreview.swift
// RefreshLoop
//
// Created by MANAS VIJAYWARGIYA on 08/08/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct NumberPreview: View {
  @EnvironmentObject var numberCountVM: NumberCountViewModel
  var previewNum: NumberCount
  
  var body: some View {
    VStack(spacing: 0) {
      Spacer()
      Text("\(previewNum.num)")
        .font(.system(size: 72, weight: .bold))
        .monospacedDigit() 
        .contentTransition(.numericText())
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 100)
        .background(Color.black.opacity(0.1).clipShape(RoundedRectangle(cornerRadius: 16)))
    }
    .padding(.horizontal, 10)
    .onTapGesture {
      numberCountVM.detailNumCount = previewNum
      numberCountVM.showDetail()
    }
    .onAppear(perform: refreshLoopState)
    .onDisappear(perform: refreshLoopState)
    .onReceive(NotificationCenter.default.publisher(for: .anyScreenDismissed)) { _ in
      refreshLoopState()
    }
  }
  
  private func refreshLoopState() {
    numberCountVM.updateRefreshLoopState()
  }
}

#Preview {
  NumberPreview(previewNum: NumberCount(id: "", num: 0))
    .environmentObject(NumberCountViewModel())
}
