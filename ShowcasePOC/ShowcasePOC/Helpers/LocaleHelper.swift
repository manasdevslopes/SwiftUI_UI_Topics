//
// LocaleHelper.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 27/05/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
import Foundation

class LocaleHelper {
  // Formatting Timestamp
  static func formatTimeStamp(_ timeStamp: Double, locale: Locale = .current) -> String? {
    let date = Date(timeIntervalSince1970: timeStamp)
    let formatter = DateFormatter()
    // formatter.dateFormat = "MMM dd, yyyy h:mm a"
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    formatter.timeZone = .current
    formatter.locale = locale
    return formatter.string(from: date)
  }
  
  /// Localized Number system
  static func numberFormatted(_ num: Double, decimals: Int = 1, locale: Locale? = .current) -> String? {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.minimumFractionDigits = decimals
    numberFormatter.maximumFractionDigits = decimals
    numberFormatter.locale = locale
    
    let formatterNumber = "\(numberFormatter.string(from: NSNumber(value: num.roundUp(toPlaces: decimals))) ?? "0.00")"
    return formatterNumber
  }
}

extension Double {
  func roundUp(toPlaces places: Int) -> Double {
    /**
     num = 56128234.567 and places = 2
     10² = 100
     56128234.567 * 100 = 5612823456.7
     5612823456.7.rounded(.up) → 5612823457
     5612823457 / 100 = 56128234.57
     */
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded(.up) / divisor
  }
}
