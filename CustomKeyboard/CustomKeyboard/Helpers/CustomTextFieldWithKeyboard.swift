//
//  CustomTextFieldWithKeyboard.swift
//  CustomKeyboard
//
//  Created by MANAS VIJAYWARGIYA on 21/02/25.
//

import SwiftUI

struct CustomTextFieldWithKeyboard<TextField: View, Keyboard: View>: UIViewControllerRepresentable {
  @ViewBuilder var textField: TextField
  @ViewBuilder var keyboard: Keyboard
  
  typealias UIHostingTextField = UIHostingController<TextField>
  
  func makeUIViewController(context: Context) -> UIHostingTextField {
    let controller = UIHostingController(rootView: textField)
    controller.view.backgroundColor = .clear
    
    DispatchQueue.main.async {
      if let textField = controller.view.allSubviews.first(where: { $0 is UITextField }) as? UITextField,
         textField.inputView == nil {
        let inputController = UIHostingController(rootView: keyboard)
        inputController.view.backgroundColor = .clear
        inputController.view.frame = .init(origin: .zero, size: inputController.view.intrinsicContentSize)
        textField.inputView = inputController.view
        textField.reloadInputViews()
      }
    }
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIHostingTextField, context: Context) { }
  
  func sizeThatFits(_ proposal: ProposedViewSize, uiViewController: UIHostingController<TextField>, context: Context) -> CGSize? {
    return uiViewController.view.intrinsicContentSize
  }
}

/// Finding UITextField from the UIHosting Controller
fileprivate extension UIView {
  var allSubviews: [UIView] {
    return self.subviews.flatMap({ [$0] + $0.allSubviews })
  }
}

#Preview {
  ContentView()
}
