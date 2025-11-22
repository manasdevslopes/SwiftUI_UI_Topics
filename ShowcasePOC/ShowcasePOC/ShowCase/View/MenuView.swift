//
// MenuView.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 26/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct MenuView: View {
  @EnvironmentObject var primeViewModel: PrimeViewModel
  @ObservedObject var menuViewModel = MenuViewModel.shared
  
  var body: some View {
    VStack {
      GeometryReader { geo in
        ScrollView(showsIndicators: false) {
          VStack(alignment: .leading) {
            Image(systemName: "xmark").resizable().scaledToFit().frame(width: 16, height: 16)
              .padding(.top, 88).padding(.bottom, 10).padding(.leading)
              .onTapGesture {
                primeViewModel.hideMenu()
              }
            
            Divider()
            
            VStack(alignment: .leading) {
              Label(LocalizationManager.shared.localizedString(forKey: "my_account"), systemImage: "person")
                .frame(maxWidth: .infinity, minHeight: 48.0, idealHeight: 55.0, maxHeight: 55.0, alignment: .leading).padding(.leading)
                .contentShape(.rect)
                .onTapGesture {
                  menuViewModel.navigateToUserProfile()
                  primeViewModel.hideMenu()
                }
              Label(LocalizationManager.shared.localizedString(forKey: "charging_history"), systemImage: "ev.charger")
                .frame(maxWidth: .infinity, minHeight: 48.0, idealHeight: 55.0, maxHeight: 55.0, alignment: .leading).padding(.leading)
                .contentShape(.rect)
                .onTapGesture {
                  menuViewModel.navigateToChargingHistory()
                  primeViewModel.hideMenu()
                }
              Label(LocalizationManager.shared.localizedString(forKey: "my_vehicle"), systemImage: "car")
                .frame(maxWidth: .infinity, minHeight: 48.0, idealHeight: 55.0, maxHeight: 55.0, alignment: .leading).padding(.leading)
                .showCase(step: .step10, cornerRadius: 0)
                .contentShape(.rect)
                .onTapGesture {
                  menuViewModel.navigateToVehicle()
                  primeViewModel.hideMenu()
                }
              Label(LocalizationManager.shared.localizedString(forKey: "my_fuel_and_charge_cards"), systemImage: "person.crop.square.filled.and.at.rectangle.fill")
                .frame(maxWidth: .infinity, minHeight: 48.0, idealHeight: 55.0, maxHeight: 55.0, alignment: .leading).padding(.leading)
                .contentShape(.rect)
                .onTapGesture {
                  menuViewModel.navigateToCards()
                  primeViewModel.hideMenu()
                }
            }
          }
        }
      }
    }
    .background {
      Color.sanatan.shadow(radius: 5, x: 3, y: 0)
    }
    .navigationTitle("")
    .navigationBarHidden(true)
    .navigationBarBackButtonHidden()
    .edgesIgnoringSafeArea(.all)
    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
      .onEnded {value in
        if value.translation.width < -30 {
          primeViewModel.hideMenu()
        }
      }
    )
  }
}

#Preview {
  HomeView()
    .environmentObject(PrimeViewModel())
}
