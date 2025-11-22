//
// MapView.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 26/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//

import MapKit
import SwiftUI

struct MapView: View {
  @ObservedObject var menuViewModel = MenuViewModel.shared
  @State private var cameraPosition = MapCameraPosition.region(
    MKCoordinateRegion(
      center: CLLocationCoordinate2D(
        latitude: 37.3346,
        longitude: -122.0090
      ),
      latitudinalMeters: 1000,
      longitudinalMeters: 1000
    )
  )
  
  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        ZStack {
          Group {
            Map(position: $cameraPosition).ignoresSafeArea()
            MainButtonsView()
          }
          .frame(maxHeight: .infinity)
        }
      }
    }
    .fullScreenCover(isPresented: $menuViewModel.isShowingSelectedMenuOptionView) {
      if let selectedMenuOption = menuViewModel.selectedMenuOptionView {
        selectedMenuOption
      }
    }
  }
}

#Preview {
  HomeView()
    .environmentObject(PrimeViewModel())
}
