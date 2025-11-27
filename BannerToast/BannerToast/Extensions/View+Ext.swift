//
// View+Ext.swift
// BannerToast
//
// Created by MANAS VIJAYWARGIYA on 27/11/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

extension View {
  @ViewBuilder func `if`<M: View>(_ condition: Bool, transform: (Self) -> M) -> some View {
    condition ? AnyView(transform(self)) : AnyView(self)
  }
}
