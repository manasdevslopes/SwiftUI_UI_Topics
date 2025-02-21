//
//  IfOptionalModifier.swift
//  OptionalModifiers
//
//  Created by MANAS VIJAYWARGIYA on 21/02/25.
//

import SwiftUI

struct IfOptionalModifier: View {
  
  var body: some View {
    VStack(spacing: 25) {
      ViewOne()
      ViewTwo()
    }
  }
}

#Preview {
  IfOptionalModifier()
}

struct ViewOne: View {
  @State private var textBold: Bool = false
  @State private var shadow: Bool = true
  var body: some View {
    Button {
      withAnimation {
        textBold.toggle()
        shadow.toggle()
      }
    } label: {
      Text("Hello, SwiftUI!").font(.system(size: 50.0)).foregroundStyle(.black)
        .if(textBold) { $0.bold().underline(pattern: .dash, color: .mint) }
        .if(shadow) { $0.shadow(color: .gray, radius: 3.0, x: 0, y: 5) }
    }
  }
}

struct ViewTwo: View {
  @State private var goToTerms: Bool = false
  
  var body: some View {
    Button {
      goToTerms.toggle()
    } label: {
      Text("Open Conditional FullScreen").font(.system(size: 25.0)).foregroundStyle(.black)
    }
    .if(goToTerms) { $0.fullScreenCover(isPresented: $goToTerms, content: {
      ZStack {
        Color.mint.ignoresSafeArea()
        
        ZStack(alignment: .topTrailing) {
          Button(action: {
            goToTerms = false
          }) {
            Text("X").font(.system(size: 30.0, weight: .bold)).foregroundStyle(.red).padding()
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)

        Text("Hello, SwiftUI!").font(.system(size: 50.0)).foregroundStyle(.black)
          .underline(pattern: .solid, color: .yellow).shadow(color: .gray, radius: 3.0, x: 0, y: 5)
      }
    })}
  }
}


extension View {
  @ViewBuilder func `if`<M: View>(_ condition: Bool, transform: (Self) -> M) -> some View {
    condition ? AnyView(transform(self)) : AnyView(self)
  }
}
