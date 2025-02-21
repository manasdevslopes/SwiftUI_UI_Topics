//
//  StyleTwo.swift
//  DynamicMultiStepProgressBar
//
//  Created by MANAS VIJAYWARGIYA on 21/02/25.
//

import SwiftUI

struct StyleTwo: View {
  var StepsNum: Int
  @Binding var currentStep: Int
  
  var body: some View {
    HStack(spacing: 0) {
      ForEach(0..<StepsNum, id: \.self) { item in
        Circle().stroke(lineWidth: 3)
          .frame(width: 40, height: 40)
          .foregroundStyle(item < currentStep ? .DL : .BG)
          .overlay {
            Text("Step \(item + 1)")
              .fixedSize().offset(x: 3, y: 45).foregroundStyle(item <= currentStep ? .DL : .BG)
          }
          .overlay {
            if item < currentStep {
              Image(systemName: "checkmark.circle.fill").resizable()
                .frame(width: 40, height: 40).foregroundStyle(.primary).transition(.scale)
            }
          }
        if item < StepsNum - 1 {
          ZStack(alignment: .leading) {
            Rectangle().frame(height: 3).foregroundStyle(.BG)
            Rectangle().frame(height: 3)
              .frame(maxWidth: item >= currentStep ? 0 : .infinity, alignment: .leading)
              .foregroundStyle(.primary)
          }
        }
      }
    }
    .frame(height: 50)
  }
}

#Preview {
  HomeView()
}
