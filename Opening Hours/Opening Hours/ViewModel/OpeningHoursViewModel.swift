//
// OpeningHoursViewModel.swift
// Opening Hours
//
// Created by MANAS VIJAYWARGIYA on 06/06/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
import Foundation
import SwiftUI
import Observation

// MARK: - Row Model used by the UI
struct OpeningRow: Identifiable, Hashable {
  let id = UUID()
  let day: String
  let open: String
  let startWeekday: Int // 0 = Mon ... 6 = Sun
  let endWeekday: Int
  let periodBegin: String? // "HH:mm"
  let periodEnd: String?
  let isClosed: Bool
  let isOpen24h: Bool
}

// MARK: - Status enum + display metadata
enum OpeningStatus: Equatable {
  case openNow(closesAt: String)
  case closesSoon(closesAt: String)
  case closed(nextOpenLabel: String)
  case open24h
  case unknown
  
  var label: String {
    switch self {
      case .openNow:                   return "Open now"
      case .closesSoon(let t):         return "Closes at \(t)"
      case .closed(let next):          return "Closed • \(next)"
      case .open24h:                   return "Open 24h"
      case .unknown:                   return "Hours unavailable"
    }
  }
  
  var dotColor: Color {
    switch self {
      case .openNow, .open24h:           return Color.green
      case .closesSoon:                  return Color.yellow
      case .closed, .unknown:            return .gray
    }
  }
  
  var backgroundColor: Color {
    switch self {
      case .openNow, .open24h:           return Color.green.opacity(0.25)
      case .closesSoon:                  return Color.yellow.opacity(0.35)
      case .closed, .unknown:            return .gray.opacity(0.15)
    }
  }
  
  var shouldPulse: Bool {
    switch self {
      case .openNow, .open24h:           return true
      default:                           return false
    }
  }
}

@Observable
final class OpeningHoursViewModel {
  // Input
  var chargingStation: LocationModel
  
  init(chargingStation: LocationModel) {
    self.chargingStation = chargingStation
  }
  
  // MARK: - Derived Data
  var openingHours: [OpeningRow] {
    if chargingStation.isOpen24_7 ?? false {
      let mon = "Monday"
      let sun = "Sunday"
      return [OpeningRow(
        day: "\(mon) - \(sun)", open: "24 Hours", startWeekday: 0, endWeekday: 6, periodBegin: nil, periodEnd: nil, isClosed: false, isOpen24h: true
      )]
    }
    
    let closedText = "Closed"
    
    var dayTime: [Int: String] = [:]
    var dayBeginEnd: [Int: (String, String)] = [:]
    for i in 0...6 { dayTime[i] = closedText }
    
    for timeframe in chargingStation.timeframes() {
      guard let day = timeframe.weekday, (0...6).contains(day) else { continue }
      let time = formattedTime(timeframe)
      if !time.isEmpty {
        dayTime[day] = time
        if let b = timeframe.periodBegin, let e = timeframe.periodEnd, !b.isEmpty, !e.isEmpty {
          dayBeginEnd[day] = (b, e)
        }
      }
    }
    
    var result: [OpeningRow] = []
    var groupStart = 0
    for day in 0...6 {
      let isLastDay = (day == 6)
      let nextIsDifferent = !isLastDay && dayTime[day + 1] != dayTime[groupStart]
      if isLastDay || nextIsDifferent {
        let label = (groupStart == day) ? weekdayName(groupStart) : "\(weekdayName(groupStart)) - \(weekdayName(day))"
        let openText = dayTime[groupStart] ?? closedText
        let isClosed = (openText == closedText)
        let be = dayBeginEnd[groupStart]
        result.append(OpeningRow(
            day: label,
            open: openText,
            startWeekday: groupStart,
            endWeekday: day,
            periodBegin: be?.0,
            periodEnd: be?.1,
            isClosed: isClosed,
            isOpen24h: false
        ))
        groupStart = day + 1
      }
    }
    return result
  }
  
  // MARK: - Row stylings
  func isCurrentlyOpen(_ row: OpeningRow) -> Bool {
    if row.isClosed { return false }
    if row.isOpen24h { return true }
    
    let today = todayWeekdayMonZero()
    guard (row.startWeekday...row.endWeekday).contains(today) else { return false }
    
    guard let begin = row.periodBegin, let end = row.periodEnd else { return false }
    let now = currentHHmm()
    /// String compare is safe for "HH:mm"
    return now >= begin && now <= end
  }
  
  /// Calendar gives Sun=1...Sat=7. Convert to Mon=0...Sun=6.
  private func todayWeekdayMonZero(now: Date = Date()) -> Int {
    let comp = Calendar.current.component(.weekday, from: now) // 1...7
    return (comp + 5) % 7
  }
  
  private func currentHHmm(now: Date = Date()) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIZ")
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: now)
  }
  
}

// MARK: - Opening Status Pills Methods
extension OpeningHoursViewModel {
  func currentStatus(now: Date = Date()) -> OpeningStatus {
    let rows = openingHours
    
    if rows.isEmpty { return .unknown }
    if rows.count == 1, rows[0].isOpen24h { return .open24h }
    
    let today = todayWeekdayMonZero(now: now)
    let nowStr = currentHHmm(now: now)
    
    // Row covering today (must be non-closed and have begin/end)
    let todayRow = rows.first { row in
      !row.isClosed
      && !row.isOpen24h
      && (row.startWeekday...row.endWeekday).contains(today)
      && row.periodBegin != nil && row.periodEnd != nil
    }
    
    if let row = todayRow, let begin = row.periodBegin, let end = row.periodEnd {
      
      if nowStr >= begin && nowStr <= end {
        let minutesLeft = minutesBetween(from: nowStr, to: end)
        if minutesLeft >= 0 && minutesLeft < 30 {
          return .closesSoon(closesAt: end)
        }
        return .openNow(closesAt: end)
      }
      
      if nowStr < begin {
        // Closed but opens later today
        let opens = "Opens"
        return .closed(nextOpenLabel: "\(opens) \(begin)")
      }
      // else: already past today's end -> fall through to next-day search
    }
    
    // Find next opening within the next 7 days
    if let label = nextOpeningLabel(after: now) {
      return .closed(nextOpenLabel: label)
    }
    return .unknown
  }
  
  private func nextOpeningLabel(after now: Date) -> String? {
    let today = todayWeekdayMonZero(now: now)
    let opens = "Opens"
    let tomorrow = "Tomorrow"
    
    for offset in 1...7 {
      let d = (today + offset) % 7
      let candidate = openingHours.first { row in
        !row.isClosed
        && !row.isOpen24h
        && (row.startWeekday...row.endWeekday).contains(d)
        && row.periodBegin != nil
      }
      
      if let begin = candidate?.periodBegin {
        if offset == 1 { return "\(tomorrow) \(begin)" }
        return "\(opens) \(weekdayName(d)) \(begin)"
      }
    }
    return nil
  }
  
  private func minutesBetween(from: String, to: String) -> Int {
    let f = from.split(separator: ":")
    let t = to.split(separator: ":")
    guard f.count == 2, t.count == 2,
          let fh = Int(f[0]), let fm = Int(f[1]),
          let th = Int(t[0]), let tm = Int(t[1]) else { return -1 }
    return (th * 60 + tm) - (fh * 60 + fm)
  }
}

// MARK: - Opening Hours methods
extension OpeningHoursViewModel {
  private func formattedTime(_ timeFrame: TimeFrame) -> String {
    var text = ""
    if let begin = timeFrame.periodBegin, !begin.isEmpty { text += begin }
    if let end = timeFrame.periodEnd, !end.isEmpty {
      if !text.isEmpty { text += " - " }
      text += end
    }
    return text
  }
  
  // 0 = Monday ... 6 = Sunday
  private func weekdayName(_ weekday: Int) -> String {
    switch weekday {
      case 0: return "Monday"
      case 1: return "Tuesday"
      case 2: return "Wednesday"
      case 3: return "Thursday"
      case 4: return "Friday"
      case 5: return "Saturday"
      case 6: return "Sunday"
      default: return "-"
    }
  }
}
