/*:
 [< Previous](@previous)                    [Home](Introduction)                    [Next >](@next)
 ## DateFormatter - dateStyle and timeStyle
 A formatter that converts between dates and their textual representations.
 */
import Foundation

// Use the current Date for each example
let currentDateAndTime = Date.now

code(for: "dateStyle") {
  let dateFormatter = DateFormatter()
  dateFormatter.dateStyle = .full
  print(".full", dateFormatter.string(from: currentDateAndTime))
  dateFormatter.dateStyle = .short
  print(".short", dateFormatter.string(from: currentDateAndTime))
  dateFormatter.dateStyle = .medium
  print(".medium", dateFormatter.string(from: currentDateAndTime))
  dateFormatter.dateStyle = .long
  print(".long", dateFormatter.string(from: currentDateAndTime))
  dateFormatter.dateStyle = .none
  print(".none", dateFormatter.string(from: currentDateAndTime))
}

code(for: "timeStyle") {
  let dateFormatter = DateFormatter()
  dateFormatter.timeStyle = .full
  print(".full", dateFormatter.string(from: currentDateAndTime))
  dateFormatter.timeStyle = .short
  print(".short", dateFormatter.string(from: currentDateAndTime))
  dateFormatter.timeStyle = .medium
  print(".medium", dateFormatter.string(from: currentDateAndTime))
  dateFormatter.timeStyle = .long
  print(".long", dateFormatter.string(from: currentDateAndTime))
  dateFormatter.timeStyle = .none
  print(".none", dateFormatter.string(from: currentDateAndTime))
}

code(for: "Combine dateStyle and timeStyle") {
  let dateFormatter = DateFormatter()
  dateFormatter.dateStyle = .long
  dateFormatter.timeStyle = .short
  print(dateFormatter.string(from: currentDateAndTime))
}

code(for: "Print date as above but for French locale") {
  let dateFormatter = DateFormatter()
  dateFormatter.dateStyle = .long
  dateFormatter.timeStyle = .short
  dateFormatter.locale = Locale(identifier: "fr_FR")
  print(dateFormatter.string(from: currentDateAndTime))
}

code(for: "Time Only") {
  let dateFormatter = DateFormatter()
  dateFormatter.timeStyle = .short
  print(dateFormatter.string(from: currentDateAndTime))
}
/*:
 [< Previous](@previous)                    [Home](Introduction)                    [Next >](@next)
 */
