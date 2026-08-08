//
// ContentView.swift
// RefreshLoop
//
// Created by MANAS VIJAYWARGIYA on 08/08/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct ContentView: View {
  @EnvironmentObject var numberCountVM: NumberCountViewModel
  
  var body: some View {
    ZStack(alignment: .bottom) {
      VStack(spacing: 0) {
        VStack {
          Button {
            Task {
              await numberCountVM.openPreview(id: UUID().uuidString)
            }
          } label: {
            Text("Open Number Count Preview")
          }
          .tint(.orange.opacity(0.85))
          .buttonStyle(.glassProminent)
          
          Button {
            numberCountVM.openRandomScreen.toggle()
          } label: {
            Text("Open Random Screen!")
          }
          .tint(.red.opacity(0.85))
          .buttonStyle(.glassProminent)
          
        }
        .frame(maxHeight: .infinity)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .contentShape(Rectangle())
      .onTapGesture {
        numberCountVM.hidePreview()
      }
      .sheet(isPresented: $numberCountVM.openRandomScreen) {
        NotificationCenter.default.post(name: .anyScreenDismissed, object: nil)
      } content: {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum dictum consequat orci, lobortis commodo nulla suscipit eget. Nam pretium scelerisque libero, eget pulvinar mauris elementum sit amet. Vestibulum eget mi suscipit libero pellentesque mollis et nec ipsum. Quisque sagittis lacinia faucibus. Proin tempor ipsum ut eros consequat molestie. Nam nec posuere tellus. Vivamus luctus orci sed laoreet semper. Sed nec metus dui. Cras sit amet odio aliquam nibh elementum eleifend quis ut turpis. Curabitur velit erat, faucibus quis turpis ut, porttitor eleifend dui. Proin ex est, tristique laoreet placerat porta, ornare et mi. Sed justo metus, consequat finibus lobortis sed, lacinia vel nulla. Donec sit amet lectus in eros interdum suscipit nec vel nisi. Donec eget purus imperdiet, volutpat felis quis, tincidunt mi. Morbi commodo aliquet pharetra. Vestibulum pulvinar dolor sem, a condimentum ligula luctus eget.")
          .font(.system(size: 16, weight: .light, design: .monospaced))
          .multilineTextAlignment(.leading)
          .padding()
      }

      
      // MARK: - Number Preview
      if numberCountVM.showPreviewOfNumCount,
         let previewNum = numberCountVM.previewNumCount {
        
        NumberPreview(previewNum: previewNum)
          // .id(numberCountVM.numberCountRenderVersion)
          .padding(.bottom, 20)
          .transition(
            .move(edge: .bottom)
            .combined(with: .opacity)
          )
          .zIndex(1)
      }
      
      if numberCountVM.showDetailOfNumCount, let detailNum = numberCountVM.detailNumCount {
        NumberDetails(detailsNum: detailNum)
          .zIndex(3)
      }
      
    }
    .animation(.easeInOut(duration: 0.35),value: numberCountVM.showPreviewOfNumCount)
    
  }
}

#Preview {
  ContentView()
    .environmentObject(NumberCountViewModel())
}
