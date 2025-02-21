//
//  TextFieldActions.swift
//  TextFieldMenu
//
//  Created by MANAS VIJAYWARGIYA on 21/02/25.
//

import SwiftUI

extension TextField {
  @ViewBuilder
  func menu(showSuggestions: Binding<Bool>, @TextFieldActionBuilder actions: @escaping () -> [TextFieldAction]) -> some View {
    self
      .background(TextFieldActionHelper(showSuggestions: showSuggestions, actions: actions()))
      .compositingGroup()
  }
}

struct TextFieldAction {
  var title: String
  var action: (NSRange, UITextField) -> ()
}

@resultBuilder
struct TextFieldActionBuilder {
  static func buildBlock(_ components: TextFieldAction...) -> [TextFieldAction] {
    components.compactMap({ $0 })
  }
}

fileprivate struct TextFieldActionHelper: UIViewRepresentable {
  var showSuggestions: Binding<Bool>
  var actions: [TextFieldAction]
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func makeUIView(context: Context) -> UIView {
    let view = UIView(frame: .zero)
    view.backgroundColor = .clear
    
    DispatchQueue.main.async {
      if let textField = view.superview?.superview?.subviews.last?.subviews.first as? UITextField {
        textField.delegate = context.coordinator
      }
    }
    return view
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) { }
  
  class Coordinator: NSObject, UITextFieldDelegate {
    var parent: TextFieldActionHelper
    init(_ parent: TextFieldActionHelper) {
      self.parent = parent
    }
    
    func textField(_ textField: UITextField, editMenuForCharactersIn range: NSRange, suggestedActions: [UIMenuElement]) -> UIMenu? {
      var actions: [UIMenuElement] = []
      let customActions = parent.actions.compactMap { item in
        let action = UIAction(title: item.title) { _ in
          item.action(range, textField)
        }
        return action
      }
      if parent.showSuggestions.wrappedValue {
        actions = customActions + suggestedActions
      } else {
        actions = customActions
      }
      
      let menu = UIMenu(children: actions)
      return menu
    }
  }
}

#Preview {
  ContentView()
}
