//
// MainButtonsView.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 26/04/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct MainButtonsView: View {
  @EnvironmentObject var primeViewModel: PrimeViewModel
  @AppStorage("displayShowCase") private var displayShowCase: Bool = true

  var body: some View {
    VStack {
      HStack(spacing: 0) {
        MainButtonView(sfSymbol: "line.3.horizontal", action: {
          primeViewModel.showMenu()
        })
        .showCase(order: 8, title: "Account Management", subtitle: "Tap here to manage your card, view your charging history, or update your account", cornerRadius: 45, style: .continuous) 
        Spacer()
        MainButtonView(sfSymbol: "line.3.horizontal.decrease", action: { })
          .showCase(order: 1, title: "Filter your search", subtitle: "Quickly find charge points based on your preferences", cornerRadius: 45, style: .continuous)
      }
      .padding(.bottom, 16)
      
      HStack {
        Spacer()
        MainButtonView(sfSymbol: "heart", action: { })
          .showCase(order: 3, title: "Favorites", subtitle: "Tap here to see your favorites station", cornerRadius: 45, style: .continuous)
      }
      Spacer()
      
      VStack(alignment: .leading) {
        HStack {
          Spacer()
          MainButtonView(sfSymbol: "qrcode.viewfinder", action: {
            print("info pressed")
            displayShowCase = true
          })
            .showCase(order: 2, title: "Scan to start charging", subtitle: "Just tap here to scan the station's QR code and start charging right from the app", cornerRadius: 45, style: .continuous)
        }
        .padding(.trailing, 4)
        
        HStack {
          Spacer()
          ZStack {
            Rectangle().fill(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))).frame(width: 45, height: 83).clipShape(.capsule)
            
            VStack(spacing: 4) {
              MainButtonView(sfSymbol: "bolt.car", imageSize: 20, action: {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                  primeViewModel.changeStationType(to: .electric)
                }
              }, backgroundSize: 35, showCircle: primeViewModel.selectedStationType == .electric)
              
              MainButtonView(sfSymbol: "fuelpump", imageSize: 20, action: {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                  primeViewModel.changeStationType(to: .fuel)
                }
              }, backgroundSize: 35, showCircle: primeViewModel.selectedStationType == .fuel)
            }
          }
          .showCase(order: 0, title: "Charging or Fueling", subtitle: "Tap here to choose between charging or fueling", cornerRadius: 10, style: .continuous)
        }
        
        HStack {
          MainButtonView(sfSymbol: "info", action: { })
            .showCase(order: 4, title: "Map Legends", subtitle: "Tap here to Map Legends", cornerRadius: 45, style: .continuous)
          Spacer()
        }
      }

    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(.top, 88).padding(.leading, 12).padding(.trailing, 10).padding(.bottom, 100)
  }
}

#Preview {
  HomeView()
    .environmentObject(PrimeViewModel())
}

struct MainButtonView: View {
  var sfSymbol: String
  var imageSize: Double = 20
  var action: () -> Void
  var shadowRadius: Double = 3.0
  var backgroundSize: Double = 35
  var showCircle: Bool = true
  
  var body: some View {
    Button(action: action) {
      ZStack {
        if showCircle {
          Circle()
            .fill(Color.white)
            .frame(width: backgroundSize, height: backgroundSize)
            .shadow(radius: shadowRadius)
            .transition(.scale.combined(with: .opacity))  // Add transition
        } else {
          Color.clear
            .frame(width: backgroundSize, height: backgroundSize)
        }
        Image(systemName: sfSymbol)
          .resizable()
          .scaledToFit()
          .frame(width: imageSize, height: imageSize)
          .foregroundColor(.black)
        
      }
      .animation(.spring(response: 0.4, dampingFraction: 0.7), value: showCircle)
    }
  }
}
