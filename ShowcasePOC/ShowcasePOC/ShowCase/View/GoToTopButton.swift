//
// GoToTopButton.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 03/05/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//

import SwiftUI

struct GoToTopButton: View {
  let action: ()->()
  var body: some View {
    Circle().foregroundStyle(.orange).frame(width: 38, height: 38)
      .overlay {
        Button {
          action()
        } label: {
          Image(systemName: "chevron.up").font(.title).foregroundColor(.white).padding()
            .background(Color.orange.opacity(0.8)).clipShape(Circle()).shadow(radius: 5)
        }
      }
  }
}

#Preview {
  GoToTopButton(action: {})
}
