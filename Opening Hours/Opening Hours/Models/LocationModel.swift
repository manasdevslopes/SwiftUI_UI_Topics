//
// LocationModel.swift
// Opening Hours
//
// Created by MANAS VIJAYWARGIYA on 06/06/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
import Foundation

struct LocationModel: Hashable {
  let id: String
  let name: String?
  let isOpen24_7: Bool?
  var evses: [Evse]?
  let userDistance: Double?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case isOpen24_7 = "is_open_24_7"
    case evses
    case userDistance
  }
}

struct Evse: Hashable {
  let id: String?
  let evseID: String
  let openingTimes: [TimeFrame]?
  
  enum CodingKeys: String, CodingKey {
    case id
    case evseID = "evse_id"
    case openingTimes = "openingTimes"
  }
}

struct TimeFrame: Hashable {
  let weekday: Int?
  let periodBegin: String?
  let periodEnd: String?
  
  enum CodingKeys: String, CodingKey {
    case weekday
    case periodBegin = "period_begin"
    case periodEnd = "period_end"
  }
}

// MARK: - Methods
extension LocationModel {
  func timeframes() -> [TimeFrame] {
    guard let evses, evses.count > 0 else { return [] }
    return evses[0].openingTimes ?? []
  }
}

// MARK: - Previews
extension LocationModel {
  private static func makePreview(isOpen24_7: Bool, openingTimes: [TimeFrame]) -> LocationModel {
    LocationModel(
      id: "DE*ICE*E0000TEST*2",
      name: "E-Charge",
      isOpen24_7: isOpen24_7,
      evses: [Evse(
        id: "DE*ICE*E0000TEST*2*52.16*12.11",
        evseID: "DE*ICE*E0000TEST*2",
        openingTimes: openingTimes
      )],
      userDistance: 6162.907
    )
  }
  
  static let preview24x7: LocationModel = makePreview(isOpen24_7: true, openingTimes: [])
  
  static let previewAllDays: LocationModel = makePreview(
    isOpen24_7: false,
    openingTimes: (0...6).map { TimeFrame(weekday: $0, periodBegin: "00:00", periodEnd: "23:59")}
  )
  
  static let previewMonFriSatSunMissing: LocationModel = makePreview(
    isOpen24_7: false,
    openingTimes: [
      TimeFrame(weekday: 0, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 1, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 2, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 3, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 4, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 5, periodBegin: "06:00", periodEnd: "11:00")
    ]
  )
  
  static let previewMonThuFriSatSunMissing: LocationModel = makePreview(
    isOpen24_7: false,
    openingTimes: [
      TimeFrame(weekday: 0, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 1, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 2, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 3, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 4, periodBegin: "06:00", periodEnd: "11:00"),
      TimeFrame(weekday: 5, periodBegin: "06:00", periodEnd: "16:00")
    ]
  )
  
  static let previewMixedAllSevenDays: LocationModel = makePreview(
    isOpen24_7: false,
    openingTimes: [
      TimeFrame(weekday: 0, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 1, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 2, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 3, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 4, periodBegin: "06:00", periodEnd: "21:00"),
      TimeFrame(weekday: 5, periodBegin: "06:00", periodEnd: "16:00"),
      TimeFrame(weekday: 6, periodBegin: "06:00", periodEnd: "12:00")
    ]
  )
  
  static let previewMonThuFriSatSun: LocationModel = makePreview(
    isOpen24_7: false,
    openingTimes: [
      TimeFrame(weekday: 0, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 1, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 2, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 3, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 4, periodBegin: "06:00", periodEnd: "21:00"),
      TimeFrame(weekday: 5, periodBegin: "06:00", periodEnd: "21:00"),
      TimeFrame(weekday: 6, periodBegin: "06:00", periodEnd: "12:00")
    ]
  )
  
  static let previewTueThuFriSatSunMonMissing: LocationModel = makePreview(
    isOpen24_7: false,
    openingTimes: [
      TimeFrame(weekday: 1, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 2, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 3, periodBegin: "06:00", periodEnd: "18:00"),
      TimeFrame(weekday: 4, periodBegin: "06:00", periodEnd: "21:00"),
      TimeFrame(weekday: 5, periodBegin: "06:00", periodEnd: "21:00")
    ]
  )
  
}
