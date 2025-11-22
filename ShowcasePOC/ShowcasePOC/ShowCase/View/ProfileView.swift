//
// ProfileView.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 30/08/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//

import MapKit
import SwiftUI

struct ProfileView: View {
  @State private var showSheet: Bool = false
  @State private var showAnotherSheet: Bool = false
  @State private var textHeight: CGFloat = .zero
  
  var body: some View {
    VStack {
      Text(LocalizationManager.shared.localizedString(forKey: "profile"))
      HyperLinkedTextLabel(
        fullTextKey: "welcome_text",
        placeholders: ["${common_terms_of_use}", "${common_privacy_policy}"],
        tappableTextKeys: ["common_terms_of_use", "common_privacy_policy"],
        fontSize: 14,
        textColor: UIColor.darkGray,
        linkColor: UIColor.green,
        dynamicHeight: $textHeight) { val, str in
          switch val {
            case 0:
              showSheet = true
            case 1:
              showAnotherSheet = true
            default: debugPrint("Tapped link: \(str)")
          }
        }
        .frame(height: textHeight)
    }
    .padding()
    .sheet(isPresented: $showSheet) {
      ZStack(alignment: .topTrailing) {
        Map().ignoresSafeArea()
        
        Button {
          showSheet = false
        } label: {
          Image(systemName: "xmark.circle.fill")
            .font(.system(size: 28)).foregroundColor(.gray).padding()
            .background(Color(.systemBackground).opacity(0.8)).clipShape(Circle())
        }.padding()
      }
    }
    .sheet(isPresented: $showAnotherSheet) {
      Text(LocalizationManager.shared.localizedString(forKey: "finish"))
        .onTapGesture {
          self.showAnotherSheet.toggle()
        }
    }
  }
}

#Preview {
  ProfileView()
}
