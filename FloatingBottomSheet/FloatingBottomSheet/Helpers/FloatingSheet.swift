//
//  FloatingSheet.swift
//  FloatingBottomSheet
//
//  Created by MANAS VIJAYWARGIYA on 23/02/25.
//

import SwiftUI

extension View {
  @ViewBuilder
  func floatingBottomSheet<Content: View>(isPresented: Binding<Bool>, onDismiss: @escaping () -> () = { }, @ViewBuilder content: @escaping () -> Content) -> some View {
    self
      .sheet(isPresented: isPresented, onDismiss: onDismiss) {
        content().presentationCornerRadius(0).presentationBackground(.clear).presentationDragIndicator(.hidden)
          .background(SheetShadowRemover()).interactiveDismissDisabled()
      }
  }
}

fileprivate struct SheetShadowRemover: UIViewRepresentable {
  typealias UIViewType = UIView
  
  func makeUIView(context: Context) -> UIView {
    let view = UIView(frame: .zero)
    view.backgroundColor = .clear
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
      if let uiSheetView = view.viewBeforeWindow {
        // uiSheetView.alpha = 0
        for view in uiSheetView.subviews {
          /// Clearing shadows
          view.layer.shadowColor = UIColor.clear.cgColor
        }
      }
    }
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) { }
}

fileprivate extension UIView {
  var viewBeforeWindow: UIView? {
    if let superview, superview is UIWindow {
      return self
    }
    
    return superview?.viewBeforeWindow
  }
}

#Preview {
  ContentView()
}
