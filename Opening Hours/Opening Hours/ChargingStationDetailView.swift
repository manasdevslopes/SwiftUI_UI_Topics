//
// ChargingStationDetailView.swift
// Opening Hours
//
// Created by MANAS VIJAYWARGIYA on 06/06/26.
// ------------------------------------------------------------------------
// Copyright © 2026 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct ChargingStationDetailView: View {
  var chargingStation: LocationModel
  @State private var openingHoursVM: OpeningHoursViewModel
  
  init(chargingStation: LocationModel) {
    self.chargingStation = chargingStation
    self._openingHoursVM = State(initialValue: OpeningHoursViewModel(chargingStation: chargingStation))
  }
  
    var body: some View {
        VStack {
            ChargingStationDetailOpeningHours()
            .environment(openingHoursVM)
        }
        .padding()
        .onChange(of: chargingStation.id) { _, _ in
          openingHoursVM.chargingStation = chargingStation
        }
    }
}

#Preview {
  ChargingStationDetailView(chargingStation: .preview24x7)
}
