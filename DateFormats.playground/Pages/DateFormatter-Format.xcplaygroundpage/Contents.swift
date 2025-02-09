/*:
 [< Previous](@previous)                    [Home](Introduction)                    [Next >](@next)
 ## DateFormatter - Format
 You can specify a Fixed Format Date Representation
 */
import Foundation

// Sample Dates and String
let currentDateAndTime = Date.now
let sampleDate = "Monday, Apr 5, 2023 6:20 PM"
let dateString = "02-18-2020 08:03"
/*
 This is a key website: https://nsdateformatter.com
 */

code(for: "Date Format") {
  // print the current date  and time so it will appear similar to the sampleDate above for your current locale
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "EEEE, MMM d, yyyy h:mm a"
  print(dateFormatter.string(from: currentDateAndTime))
}

code(for: "Date Format with Locale") {
  // print the current date and time so it will appear similar to the dateString above but in French Canadian
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "EEEE, MMM d, yyyy h:mm a"
  dateFormatter.locale = Locale(identifier: "fr_CA")
  print(dateFormatter.string(from: currentDateAndTime))
  
  let dateFormatter1 = DateFormatter()
  dateFormatter1.dateFormat = "MM-dd-yyyy HH:mm"
  print(dateFormatter1.string(from: currentDateAndTime))
}

code(for: "Date derived from a String") {
  // Create and print a Date instance derived from the dateString above but in a different format
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
  let date = dateFormatter.date(from: dateString)
  print(date ?? "No Date")
}

code(for: "Local and TimeZone corrections") {
  // Create and print a Date instance derived from the dateString above but in a different locale
  let dateFormatter = DateFormatter()
  dateFormatter.locale = Locale(identifier: "en_US_POSIX")
  dateFormatter.timeZone = TimeZone(identifier: "UTC")
  dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
  let date = dateFormatter.date(from: dateString)
  print(date ?? "No Date")
}


/*:
 [< Previous](@previous)                    [Home](Introduction)                    [Next >](@next)
 */
