//
//  StyleFour.swift
//  DynamicMultiStepProgressBar
//
//  Created by MANAS VIJAYWARGIYA on 21/02/25.
//

import SwiftUI

struct StyleFour: View {
  var StepsNum: Int
  @Binding var currentStep: Int
  
  var body: some View {
    HStack(spacing: 0) {
      ForEach(0..<StepsNum, id: \.self) { item in
        Circle().frame(width: 40, height: item <= currentStep ? 40 : 15)
          .foregroundStyle(item < currentStep ? .LD : .BG)
          .overlay {
            if item < currentStep {
              Image(systemName: "checkmark.circle.fill").resizable()
                .frame(width: 40, height: 40).foregroundStyle(.primary).transition(.scale)
            }
          }
        if item < StepsNum - 1 {
          ZStack(alignment: .leading) {
            Rectangle().frame(height: 3).foregroundStyle(.BG)
            Rectangle().frame(height: 3).frame(maxWidth: item >= currentStep ? 0 : .infinity, alignment: .leading).foregroundStyle(.primary)
          }
        }
      }
    }
    .background(
      Rectangle().frame(height: 3)
        .foregroundStyle(.BG).frame(maxWidth: .infinity, alignment: .leading).padding(.trailing)
    )
    .frame(height: 50)
  }
}

#Preview {
  HomeView()
}
