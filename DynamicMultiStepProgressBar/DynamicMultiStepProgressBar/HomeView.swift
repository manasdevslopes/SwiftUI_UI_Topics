//
//  HomeView.swift
//  DynamicMultiStepProgressBar
//
//  Created by MANAS VIJAYWARGIYA on 21/02/25.
//

import SwiftUI

struct HomeView: View {
  @State private var StepsNum: Int = 6
  @State private var CurrentStep: Int = 0
  
  var body: some View {
    VStack(spacing: 80) {
      StyleOne(StepsNum: 4, currentStep: $CurrentStep)
      
      StyleTwo(StepsNum: 3, currentStep: $CurrentStep)
      
      StyleThree(StepsNum: 4, currentStep: $CurrentStep)
      
      StyleFour(StepsNum: 5, currentStep: $CurrentStep)
      
      HStack {
        Button {
          withAnimation {
            if CurrentStep > 0 {
              CurrentStep -= 1
            }
          }
        } label: {
          Text("Back")
        }
        .disabled(CurrentStep == 0).padding(.horizontal)
        Button {
          withAnimation {
            if CurrentStep < StepsNum {
              CurrentStep += 1
            }
          }
        } label: {
          Text("Next")
        }
        .padding(.horizontal)
      }
      .font(.largeTitle).offset(y: 10.0)
    }
    .tint(.primary)
    .padding(.horizontal)
  }
}

#Preview {
  HomeView()
}
