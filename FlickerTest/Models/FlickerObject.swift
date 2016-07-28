//
//  FlickerObject.swift
//  FlickerTest
//

// MARK: FlickerObject

import Foundation

class FlickerObject {
    var title: String = ""
    var mediaString: String = ""
    var dateFormatted: String = ""

    var dateTaken: String {
        get {
            return self.dateFormatted
        }
        set {
            //
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.dateFromString(newValue)

            let calendar: NSCalendar = NSCalendar.currentCalendar()

            let date2 = NSDate()

            let flags = NSCalendarUnit.Day
            let components = calendar.components(flags, fromDate: date!, toDate: date2, options: [])

            switch components.day {
                case 0:
                    self.dateFormatted = ("Today")
                case 1:
                    self.dateFormatted = ("Yesterday")
                default:
                    self.dateFormatted = ("\(components.day) days ago")
            }
        }
    }
}
