//
//  ListItemView.swift
//  Placeholder
//
//  Created by MANAS VIJAYWARGIYA on 22/02/25.
//

import SwiftUI

struct ListItemView: View {
  @State private var isLoading: Bool = true
  
  @State private var imageName: String = "square"
  @State private var title: String = "Placeholder Title"
  @State private var description: String = "Placeholder Description"
  
  var body: some View {
    VStack {
      if isLoading {
        content.redacted(reason: .placeholder)
      } else {
        content
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        imageName = "house"
        title = "My Image Title"
        description = "My Image Description"
        isLoading = false
      }
    }
  }
  
  var content: some View {
    HStack {
      Image(systemName: imageName).resizable().scaledToFit().frame(width: 100, height: 100)
      VStack(alignment: .leading) {
        Text(title).font(.headline)
        Text(description).font(.subheadline)
      }
    }
  }
}

struct PlaceholderView: View {
  var body: some View {
    List(0..<10, id: \.self) {_ in
      ListItemView()
    }
  }
}

#Preview {
  PlaceholderView()
}
