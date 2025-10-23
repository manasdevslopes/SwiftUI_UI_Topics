//
// ContentView.swift
// MultiSlider
//
// Created by MANAS VIJAYWARGIYA on 23/10/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI

struct ContentView: View {
  @State private var minKwValue: Float = PowerSlideState.all.rawValue
  @State private var maxKwValue: Float = PowerSlideState.thousand.rawValue
  @State private var trackHeight: Double = 5
  @State private var points = PowerSlideState.allCases
  
  var body: some View {
    VStack {
      HStack {
        Text("Minimum power (kW)").foregroundStyle(.gray).font(.system(size: 16))
        Spacer()
      }
      
      GeometryReader { geometry in
        let w = geometry.size.width
        let _ = geometry.size.height
        
        VStack {
          ZStack(alignment: .leading) {
            Rectangle().fill(.gray).frame(height: trackHeight)
              .clipShape(RoundedRectangle(cornerRadius: 10))
            Rectangle().fill(.green).frame(height: trackHeight)
              .frame(width: kwToSize(width: w, kw: maxKwValue))
              .offset(x: kwToSize(width: w, kw: minKwValue))
              .clipShape(RoundedRectangle(cornerRadius: 10))
              .accessibilityIdentifier("slider_bar")
            ForEach(points, id: \.self) { point in
              HStack(spacing: 0) {
                Circle().fill(
                  (Float(point.rawValue) <= minKwValue || Float(point.rawValue) >= maxKwValue) ? .green : .white.opacity(0.5))
                .frame(width: trackHeight / 1.5, height: trackHeight / 1.5)
                .offset(x: getOffset(width: w, percent: point.percent))
              }
            }
            
            ForEach(points, id: \.self) { point in
              HStack(spacing: 0) {
                if point.name == points.last?.name {
                  Text(point.name)
                    .offset(x: getOffset(width: w, percent: point.percent) - 10, y: 25)
                    .foregroundStyle(.gray).font(.system(size: 12))
                } else {
                  Text(point.name)
                    .offset(x: getOffset(width: w, percent: point.percent) - 5, y: 25)
                    .foregroundStyle(.gray).font(.system(size: 12))
                }
              }
            }
            
            ForEach(points, id: \.self) { point in
              HStack(spacing: 0) {
                if point.principalName != "" && point.name != points.first?.name {
                  Text(point.principalName).foregroundStyle(.green)
                    .offset(x: getOffset(width: w - 50, percent: point.percent), y: -30)
                    .font(.system(size: 14))
                } else {
                  Text(point.principalName).foregroundStyle(.green)
                    .offset(x: getOffset(width: w, percent: 0), y: -30)
                    .font(.system(size: 14))
                }
              }
            }
            
            HStack(spacing: 0) {
              Circle().fill(.green).frame(width: trackHeight * 4, height: trackHeight * 4)
                .offset(x: kwToSize(width: w, kw: minKwValue) - (trackHeight * 2 / 2))
                .gesture(DragGesture().onChanged({ value in
                  let nearestValue = getNearestPoint(width: w, location: value.location.x)
                  if nearestValue <= maxKwValue {
                    minKwValue = nearestValue
                  }
                }))
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                .accessibilityIdentifier("slider_lower_kw_btn")
            }
            
            HStack(spacing: 0) {
              Circle().fill(.green).frame(width: trackHeight * 4, height: trackHeight * 4)
                .offset(x: kwToSize(width: w, kw: maxKwValue) - (trackHeight * 2 / 2))
                .gesture(DragGesture().onChanged({ value in
                  let nearestValue = getNearestPoint(width: w, location: value.location.x)
                  if nearestValue >= minKwValue {
                    maxKwValue = nearestValue
                  }
                }))
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                .accessibilityIdentifier("slider_upper_kw_btn")
            }
          }
        }
      }
      .padding(3).padding(.top, 30).padding(.bottom, 60)
      
      Text("Min KW : \(minKwValue, specifier: "%.2f")")
      Text("Max KW : \(maxKwValue, specifier: "%.2f")")
    }
    .padding()
  }
}

#Preview {
  ContentView()
}

extension ContentView {
  private func kwToSize(width: Double, kw: Float) -> Double {
    let point = points.first { point in point.rawValue == kw } ?? points[1]
    return (width * point.percent / 100)
  }
  
  private func getOffset(width: Double, percent: Double) -> Double {
    return (width * percent / 100)
  }
  
  private func getNearestPoint(width: Double, location: Double) -> Float {
    let points = self.points.map { point in
      kwToSize(width: width, kw: point.rawValue)
    }
    var current = 0.0
    var currentIndex = 0
    for (index, point) in points.enumerated() where abs(location - point) <= abs(location - current) {
      current = point
      currentIndex = index
    }
    return self.points[currentIndex].rawValue
  }
}
