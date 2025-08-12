////
////  Notifications.swift
////  Medicine Tracker
////
////  Created by admin on 7/4/23.
////
//
//import SwiftUI
//import UserNotifications
//class NotificationManager{
//    static let instance = NotificationManager()
//
//    func requestAutherization() {
//        let options: UNAuthorizationOptions = [.alert,.sound,.badge]
//        UNUserNotificationCenter.current().requestAuthorization(options:options) { (success, error) in
//
//            }
//
//        }
//    }
//
//
//struct Notifications: View {
//    var body: some View {
//        Text("Hello World")
//    }
//
//    func scheduleNotification(medicine: medicineModel){
//        let content = UNMutableNotificationContent()
//        content.title = "Time to take your"  + medicine.title
//        content.sound = .default
//        content.badge = 1
//        let days = medicine.daysOfTheWeek
//        let time = medicine.pillDate
//        let dayOfWeekInts = days.compactMap { dayString in
//            Calendar.current.weekdaySymbols.firstIndex(of: dayString).map { index in
//                if dayString !=  "Saturday" {
//                    return ( (index + 1) % 7) } else {
//                        return  7
//                    }
//            }
//        }
//
//
//        let repeatingWeekdays: [Int] = dayOfWeekInts
//        let calendar = Calendar.current
//        var dateComponents = DateComponents()
//        let dateComponentsOfSelectedTime = calendar.dateComponents([.hour, .minute], from: time)
//        dateComponents.hour = dateComponentsOfSelectedTime.hour
//        dateComponents.minute = dateComponentsOfSelectedTime.minute
//
//        let endDate = medicine.endDate
//
//
//
//
//
//
//        for weekday in repeatingWeekdays{
//            dateComponents.weekday = weekday
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//            UNUserNotificationCenter.current().add(request)
//
//
//            if let nextNotificationDate = Calendar.current.nextDate(after: Date(), matching: dateComponents, matchingPolicy: .nextTime){
//                if nextNotificationDate > endDate {
//                    break
//                }
//                dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: nextNotificationDate)
//            } else {
//                break
//            }
//
//
//
//
//        }
//    }
//}
//struct Notifications_Previews: PreviewProvider {
//    static var previews: some View {
//        Notifications()
//    }
//}
