//
// ScreenB.swift
// BannerToast
//
// Created by MANAS VIJAYWARGIYA on 27/11/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct ScreenB: View {
  @Environment(\.dismiss) private var dismiss
  
  private let textBasic =
  "To start charging, enable notifications: Settings -> Notifications -> Fuel & Charge -> Allow Notifications"
  
  private let textClickable =
  "To start charging, enable notifications: Settings -> Notifications -> Fuel & Charge -> Allow Notifications. ${please_click_here}"

  var body: some View {
    VStack(spacing: 40) {
      Text("Screen B").font(.largeTitle).padding(.bottom, 20)
      
      // 1. SUCCESS (with icon, with border, no dismiss, no hyperlink tap)
      Button("Show SUCCESS Toast") {
        // makeToastWithLeadingNoDismiss
        let toast = makeToast(type: .success, hyperlinkText: textBasic, showBorder: true) {
          Image(systemName: "checkmark.seal.fill").resizable().frame(width: 24, height: 24)
        }
        
        showToastAndGoBack(toast)
      }
      
      // 2. INFO (with icon, without border, no dismiss, no hyperlink tap)
      Button("Show INFO Toast") {
        // makeToastWithLeadingNoDismiss
        let toast = makeToast(type: .info, hyperlinkText: textBasic, fontSize: 12, textColor: UIColor.darkText, showBorder: false) {
          Image(systemName: "info.circle.fill").resizable().frame(width: 24, height: 24)
        }
        showToastAndGoBack(toast)
      }
      
      // 3. WARNING (with hyperlink + dismiss, no icon)
      Button("Show WARNING Toast") {
        // makeToastNoLeadingWithDismiss
        let toast = makeToast(type: .warning, hyperlinkText: textClickable, placeholderText: "${please_click_here}", tappableText: "Please click here", showBorder: true) {
          print("Hyperlinked text tapped")
        } onDismiss: {
          print("Dismiss tapped")
        }
        
        showToastAndGoBack(toast)
      }
      
      // 4. WARNING (with hyperlink + dismiss + icon)
      Button("Show WARNING Toast 2") {
        // makeToastWithLeadingAndDismiss
        let toast = makeToast(type: .warning, hyperlinkText: textClickable, placeholderText: "${please_click_here}", tappableText: "Please click here", showBorder: true) {
          print("Hyperlinked text tapped")
        } onDismiss: {
          print("Dismiss tapped")
        } leadingContent: {
          Image(systemName: "exclamationmark.triangle.fill").resizable().frame(width: 24, height: 24)
        }
        
        showToastAndGoBack(toast)
      }
      
      // 4. ERROR (with hyperlink + dismiss + icon)
      Button("Show ERROR Toast") {
        // makeToastWithLeadingAndDismiss
        let toast = makeToast(type: .error, hyperlinkText: textClickable, placeholderText: "${please_click_here}", tappableText: "Please click here", showBorder: true) {
          print("Hyperlinked text tapped")
        } onDismiss: {
          print("Dismiss tapped")
        } leadingContent: {
          Image(systemName: "questionmark.folder").resizable().frame(width: 24, height: 24)
        }
        
        showToastAndGoBack(toast)
      }
      
      // 5. NEUTRAL (with hyperlink + dismiss + icon)
      Button("Show NEUTRAL Toast") {
        // makeToastWithLeadingAndDismiss
        let toast = makeToast(type: .neutral, hyperlinkText: textClickable, placeholderText: "${please_click_here}", tappableText: "Please click here", showBorder: true) {
          print("Hyperlinked text tapped")
        } onDismiss: {
          print("Dismiss tapped")
        } leadingContent: {
          Image(systemName: "receipt").resizable().frame(width: 24, height: 24)
        }
        showToastAndGoBack(toast)
      }
    }
  }
  
  // MARK: - Helper (All 5 buttons use this)
  private func showToastAndGoBack<T: View>(_ toast: InlineToastData<T>) {
    // InlineToastManager.shared.show(alignment: .bottom, toastType: .offsetToast, toast, duration: 5)
    InlineToastManager.shared.show(alignment: .top, toastType: .offsetToast, toast, duration: 5)
    // InlineToastManager.shared.show(toast, duration: 5)
    
//    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//      dismiss()
//    }
  }
}

#Preview {
  ScreenB()
}
