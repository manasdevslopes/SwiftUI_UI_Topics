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
        Tab("Map", systemImage: "macbook.and.iphone") {
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
        
        Tab("Items", systemImage: "square.grid.2x2.fill") {
          Text("Items")
        }
        
        Tab("Profile", systemImage: "person.circle.fill") {
          Text("Profile")
        }
      }
      .overlay(alignment: .bottom) {
        HStack(spacing: 0) {
          Circle().foregroundStyle(.clear).frame(width: 45, height: 45)
            .showCase(order: 6, title: "My Map", subtitle: "Chekout your locations and routes", cornerRadius: 10, style: .continuous)
            .frame(maxWidth: .infinity)
          Circle().foregroundStyle(.clear).frame(width: 45, height: 45)
            .showCase(order: 7, title: "Location Enabled Tag's", subtitle: "Checkout Location Enabled Tags", cornerRadius: 10, style: .continuous)
            .frame(maxWidth: .infinity)
          Circle().foregroundStyle(.clear).frame(width: 45, height: 45)
            .showCase(order: 5, title: "Personal Info", subtitle: "Check your profile here.", cornerRadius: 10, style: .continuous)
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
