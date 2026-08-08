//
// NumberDetails.swift
// RefreshLoop
//
// Created by MANAS VIJAYWARGIYA on 08/08/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct NumberDetails: View {
  @EnvironmentObject var numberCountVM: NumberCountViewModel
  var detailsNum: NumberCount
  
  var body: some View {
    VStack {
      VStack {
        HStack {
          Text("Detail")
            .gesture(
              DragGesture(minimumDistance: 20, coordinateSpace: .local)
                .onEnded({value in
                  if value.translation.height > 0 {
                    numberCountVM.hideDetail()
                  }
                })
            )
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .overlay(alignment: .leading) {
          Button {
            numberCountVM.hideDetail()
          } label: {
            Image(systemName: "arrowshape.turn.up.backward.fill")
          }
          .tint(.orange.opacity(0.85))
          .buttonStyle(.glassProminent)
        }
        .padding(.top, 32)
        .padding(.horizontal, 16)
        
        Spacer()
        
        Text("\(detailsNum.num)")
          .font(.system(size: 72, weight: .bold)).monospacedDigit()
          .contentTransition(.numericText()).frame(height: 100)
        
        Spacer()
        
      }
      .frame(height: numberCountVM.fullSheetOpenedHeight)
      .background(Color.white.opacity(0.85))
      .onAppear(perform: refreshLoopState)
    }
    .gesture(
      DragGesture(minimumDistance: 20, coordinateSpace: .local)
        .onEnded({value in
          if value.translation.width > 60 {
            numberCountVM.hideDetail()
          }
        })
    )
    .onDisappear(perform: refreshLoopState)
    .onReceive(NotificationCenter.default.publisher(for: .anyScreenDismissed)) { _ in
      refreshLoopState()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
    .transition(.move(edge: .trailing)) // .bottom
  }
  
  private func refreshLoopState() {
    numberCountVM.updateRefreshLoopState()
  }
  
}

#Preview {
  NumberDetails(detailsNum: NumberCount(id: "", num: 0))
    .environmentObject(NumberCountViewModel())
}
