/*:
 [< Previous](@previous)                    [Home](Introduction)
 ## Dates in SwiftUI iOS 15+
 Displaying dates in SwiftUI Text views using iOS 15+
 */

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
  @State private var currentDateAndTime = Date.now
  var dateformatter: DateFormatter {
    let  dateformatter = DateFormatter()
    dateformatter.dateStyle = .long
    dateformatter.timeStyle = .short
    return dateformatter
  }
  var dateFormatter2: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy"
    return dateFormatter
  }
  
  var body: some View {
    Form {
      Text("**SwiftUI iOS 15+**").font(.title)
      LabeledContent("Using format: .dateTime") {
        Text(currentDateAndTime, format: .dateTime)
      }
      LabeledContent("Using format: .dateTime +") {
        Text(currentDateAndTime, format: .dateTime
          .weekday()
          .month()
          .day()
          .year()
          .week()
          .hour()
          .minute()
          .second()
        )
      }
      LabeledContent("Using format: .dateTime + compontent options") {
        Text(currentDateAndTime, format: .dateTime
          .weekday(.wide)
          .month(.wide)
          .day(.twoDigits)
          .year()
          .hour()
          .minute()
        )
      }
      LabeledContent("Using format: special cases") {
        Text(currentDateAndTime, format: .dateTime
          .week(.weekOfMonth)
          .day(.ordinalOfDayInMonth)
        )
      }
      
      LabeledContent("Using format: Date.FormatStyle") {
        Text(currentDateAndTime, format: Date.FormatStyle(date: .complete, time: .none))
      }
      
    }
  }
}

PlaygroundPage.current.setLiveView(ContentView())


/*:
 [< Previous](@previous)                    [Home](Introduction)
 */
