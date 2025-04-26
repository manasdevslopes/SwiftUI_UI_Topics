//
// HomeView.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 26/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

extension UIScreen {
  static let screenWidth = UIScreen.main.bounds.size.width
}

struct HomeView: View {
  @EnvironmentObject var primeViewModel: PrimeViewModel
  @AppStorage("displayShowCase") private var displayShowCase: Bool = true
  
  var shouldDisplayShowcase: Bool {
    return displayShowCase
  }
  
  var body: some View {
    ZStack {
      TabView {
        Tab(LocalizationManager.shared.localizedString(forKey: "map"), systemImage: "macbook.and.iphone") {
          GeometryReader {
            let safeArea = $0.safeAreaInsets
            
            MapView()
            // To SafeArea Material View
              .overlay(alignment: .top) {
                Rectangle().fill(.ultraThinMaterial).frame(height: safeArea.top)
              }
              .ignoresSafeArea()
              .gesture(
                TapGesture()
                  .onEnded {_ in
                    primeViewModel.hideSemiViewsOverTheMap()
                  }
              )
          }
          .toolbarBackground(.visible, for: .tabBar)
          .toolbarBackground(.ultraThinMaterial, for: .tabBar)
        }
        
        Tab(LocalizationManager.shared.localizedString(forKey: "items"), systemImage: "square.grid.2x2.fill") {
          Text(LocalizationManager.shared.localizedString(forKey: "items"))
        }
        
        Tab(LocalizationManager.shared.localizedString(forKey: "profile"), systemImage: "person.circle.fill") {
          Text(LocalizationManager.shared.localizedString(forKey: "profile"))
        }
      }
      .overlay(alignment: .bottom) {
        HStack(spacing: 0) {
          Circle().foregroundStyle(.clear).frame(width: 45, height: 45)
            .showCase(order: 6, title: LocalizationManager.shared.localizedString(forKey: "my_map"), subtitle: LocalizationManager.shared.localizedString(forKey: "check_routes"), cornerRadius: 10, style: .continuous)
            .frame(maxWidth: .infinity)
          Circle().foregroundStyle(.clear).frame(width: 45, height: 45)
            .showCase(order: 7, title: LocalizationManager.shared.localizedString(forKey: "location_enable"), subtitle: LocalizationManager.shared.localizedString(forKey: "check_location_tag"), cornerRadius: 10, style: .continuous)
            .frame(maxWidth: .infinity)
          Circle().foregroundStyle(.clear).frame(width: 45, height: 45)
            .showCase(order: 5, title: LocalizationManager.shared.localizedString(forKey: "personal_info"), subtitle: LocalizationManager.shared.localizedString(forKey: "check_profile"), cornerRadius: 10, style: .continuous)
            .frame(maxWidth: .infinity)
        }
      }
      
      if primeViewModel.isMenuVisible {
        Group {
          HStack {
            MenuView().frame(width: UIScreen.screenWidth * 0.82)
            Spacer()
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .transition(.move(edge: .leading)).zIndex(100)
        }
      }
    }
    .modifier(ShowCaseRoot(showHighlights: shouldDisplayShowcase, onFinished: {
      print("Finished OnBoarding")
      displayShowCase = false
    }))
  }
}

#Preview {
  HomeView().environmentObject(PrimeViewModel())
}
