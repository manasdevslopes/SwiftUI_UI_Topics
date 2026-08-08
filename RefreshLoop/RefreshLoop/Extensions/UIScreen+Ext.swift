//
// UIScreen+Ext.swift
// RefreshLoop
//
// Created by MANAS VIJAYWARGIYA on 08/08/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import UIKit

extension UIScreen {
  static let screenHeight = UIScreen.main.bounds.size.height
}

func keyWindow() -> UIWindow? {
  (UIApplication.shared.connectedScenes.first { $0.activationState == .foregroundActive } as? UIWindowScene)?.windows.first { $0.isKeyWindow }
}
