//
// ChargingStationDetailOpeningHours.swift
// Opening Hours
//
// Created by MANAS VIJAYWARGIYA on 06/06/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct ChargingStationDetailOpeningHours: View {
  @Environment(OpeningHoursViewModel.self) private var viewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      OpeningStatusPill().padding(.bottom, 8)
      
      Text("Opening Hours")
        .font(.system(size: 16)).bold().padding(.bottom, 22)
      
      let rows = viewModel.openingHours
      if !rows.isEmpty {
        ForEach(rows) { row in
          let active = viewModel.isCurrentlyOpen(row)
          let baseTextColor: Color = active ? .white : .black
          let openTextColor: Color = row.isClosed ? Color.red : baseTextColor
          HStack {
            Text(row.day).foregroundStyle(baseTextColor)
            Spacer()
            Text(" | ").foregroundStyle(baseTextColor)
            Spacer()
            Text(row.open).foregroundStyle(openTextColor)
          }
          .font(.system(size: 16))
          .padding(.vertical, 5).padding(.horizontal, 16)
          .frame(height: 35)
          .background(
            active ? Color.green.opacity(0.95) : Color.yellow.opacity(0.95)
          )
          .clipShape(RoundedRectangle(cornerRadius: 25))
          .padding(.bottom, 10)
        }
      } else {
        Text("Information not available")
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

// MARK: - Previews
struct OpeningHoursPreviewHost: View {
  @State private var viewModel: OpeningHoursViewModel
  init(_ station: LocationModel) {
    self._viewModel = State(initialValue: OpeningHoursViewModel(chargingStation: station))
  }
  
  var body: some View {
    ChargingStationDetailOpeningHours()
      .environment(viewModel)
      .padding()
  }
}

#Preview("Opening Times 24 / 7") {
  OpeningHoursPreviewHost(.preview24x7)
}

#Preview("Opening Times - All days same") {
  OpeningHoursPreviewHost(.previewAllDays)
}

#Preview("Mon-Fri 06:00-18:00, Sat 06:00-11:00, Sun missing") {
  OpeningHoursPreviewHost(.previewMonFriSatSunMissing)
}

#Preview("Mon-Thu 06:00-18:00, Fri 06:00-11:00, Sat 06:00-16:00, Sun missing") {
  OpeningHoursPreviewHost(.previewMonThuFriSatSunMissing)
}

#Preview("Mixed All 7 days") {
  OpeningHoursPreviewHost(.previewMixedAllSevenDays)
}

#Preview("Mon-Thu + Fri-Sat + Sun") {
  OpeningHoursPreviewHost(.previewMonThuFriSatSun)
}

#Preview("Tues-Thu + Fri-Sat + Sun & Mon Missing") {
  OpeningHoursPreviewHost(.previewTueThuFriSatSunMonMissing)
}
