//
// Notification+Ext.swift
// RefreshLoop
//
// Created by MANAS VIJAYWARGIYA on 08/08/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import NotificationCenter

extension Notification.Name {
  // MARK: - For Refresh to avoid latency
  static let anyScreenDismissed = Notification.Name("anyScreenDismissed")
}
