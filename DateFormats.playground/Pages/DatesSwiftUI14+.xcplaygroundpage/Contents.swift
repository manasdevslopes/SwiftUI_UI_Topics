/*:
 [< Previous](@previous)                    [Home](Introduction)                    [Next >](@next)
 ## Dates in SwiftUI iOS 14+
 Displaying dates in SwiftUI Text views using iOS 14+
 */

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
  @State private var currentDateAndTime = Date.now
  var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .short
    return dateFormatter
  }
  
  var dateFormatter2: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy"
    return dateFormatter
  }
  
  var body: some View {
    Form {
      Text("**SwiftUI iOS 14+**").font(.title)
      LabeledContent("Using String Interpolation") {
        Text("\(currentDateAndTime)")
      }
      let dateString = dateFormatter.string(from: currentDateAndTime)
      LabeledContent("Old Method for DateFormatter") {
        Text(dateString)
      }
      LabeledContent("New Method for DateFormatter") {
        Text(currentDateAndTime, formatter: dateFormatter)
      }
      LabeledContent("Using Style Date") {
        Text(currentDateAndTime, style: .date)
      }
      LabeledContent("Using Style time") {
        Text(currentDateAndTime, style: .time)
      }
      LabeledContent("Using Style timer") {
        Text(currentDateAndTime, style: .timer)
      }
      LabeledContent("Using Style relative") {
        Text(currentDateAndTime, style: .relative)
      }
      Group {
        // create a date for Christmas of this year
        let christmas = dateFormatter2.date(from: "12-25-2025")!
        LabeledContent("Offset til Christmas") {
          Text(christmas, style: .offset)
        }
        // create a date for tomorrow
        let tomorrow = dateFormatter2.date(from: "02-10-2025")!
        LabeledContent("Offset til tomorrow") {
          Text(tomorrow, style: .offset)
        }
        // create a date for 59 seconds from now
        let soon = currentDateAndTime.addingTimeInterval(59)
        LabeledContent("Offset til soon") {
          Text(soon, style: .offset)
        }
      }
      Button("Reset Date"){
        currentDateAndTime = Date.now
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
      .buttonStyle(.borderedProminent)
    }
  }
}

PlaygroundPage.current.setLiveView(ContentView())


/*:
 [< Previous](@previous)                    [Home](Introduction)            [Next >](@next)
 */
