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
  
  var body: some View {
    VStack {
      Text(LocalizationManager.shared.localizedString(forKey: "profile"))
      HyperLinkedTextLabel(
        fullTextKey: LocalizationManager.shared.localizedString(forKey: "location_details_connectors_disclaimer"),
        placeholder: "${filter_link}",
        tappableText: LocalizationManager.shared.localizedString(forKey: "location_details_filter_placeholder"),
        fontSize: 14,
        textColor: UIColor.darkGray,
        linkColor: UIColor.green) { _ in
          showSheet = true
        }
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
  }
}

#Preview {
  ProfileView()
}
