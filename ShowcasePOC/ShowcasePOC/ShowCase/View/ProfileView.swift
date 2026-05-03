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
  @State private var textHeight1: CGFloat = .zero

  
  var body: some View {
    VStack {
      Text(LocalizationManager.shared.localizedString(forKey: "profile"))
      
      LText(key: "profile").font(AppFont.shantellSans(.regular, size: 16))
      LText(key: "profile").font(AppFont.shantellSans(.italic, size: 16))
      LText(key: "profile").font(AppFont.shantellSans(.light, size: 16))
      LText(key: "profile").font(AppFont.shantellSans(.lightItalic, size: 16))
      LText(key: "profile").font(AppFont.shantellSans(.medium, size: 16))
      LText(key: "profile").font(AppFont.shantellSans(.mediumItalic, size: 16))
      LText(key: "profile").font(AppFont.shantellSans(.bold, size: 16))
      LText(key: "profile").font(AppFont.shantellSans(.boldItalic, size: 16))
      LText(key: "profile").font(AppFont.shantellSans(.semiBold, size: 16))
      LText(key: "profile").font(AppFont.shantellSans(.semiBoldItalic, size: 16))
      LText(key: "profile").font(AppFont.shantellSans(.extraBold, size: 16))
      LText(key: "profile").font(AppFont.shantellSans(.extraBoldItalic, size: 16))
      LText(key: "profile").font(AppFont.corinthia(.regular, size: 20))
      LText(key: "profile").font(AppFont.corinthia(.bold, size: 20))
      
      HyperLinkedTextLabel(
        fullTextKey: "welcome_text",
        placeholders: ["${common_terms_of_use}", "${common_privacy_policy}"],
        tappableTextKeys: ["common_terms_of_use", "common_privacy_policy"],
        fontSize: 24,
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
      
      Divider().padding(.vertical, 16)
      
      HyperLinkedTextLabel(
        fullTextKey: "welcome_text",
        placeholders: ["${common_terms_of_use}", "${common_privacy_policy}"],
        tappableTextKeys: ["common_terms_of_use", "common_privacy_policy"],
        fontSize: 24,
        textColor: UIColor.darkGray,
        linkColor: UIColor.green,
        textAlignment: .left,
        baseTextShantellSans: .italic,
        baseTextCorinthiaFont: .regular,
        tappableTextShantellSans: .semiBold,
        tappableTextCorinthiaFont: .bold,
        dynamicHeight: $textHeight1) { val, str in
          switch val {
            case 0:
              showSheet = true
            case 1:
              showAnotherSheet = true
            default: debugPrint("Tapped link: \(str)")
          }
        }
        .frame(height: textHeight1)
      
      Spacer()
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
      ScrollViewReaderView(showAnotherSheet: $showAnotherSheet)
    }
  }
}

#Preview("English") {
  ProfileView().environment(\.locale, .en)
}

#Preview("German") {
  ProfileView().environment(\.locale, .de)
}
