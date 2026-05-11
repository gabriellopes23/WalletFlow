//
//  NotificationCenter.swift
//  WalletFlow
//
//  Created by Gabriel Lopes on 08/05/26.
//

import Foundation
import UserNotifications

class NotificationService: NSObject, UNUserNotificationCenterDelegate {
    
    func authorizeNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if success {
                print("Sucesso")
            } else if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func removePendingNotificaions() {
        let center = UNUserNotificationCenter.current()
        
        center.removePendingNotificationRequests(withIdentifiers: ["month_summary"])
    }
    
    func scheduleExpenseAlert() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let content = UNMutableNotificationContent()
        content.title = "⚠️ Budget Limit Reached"
        content.body = "Your expenses have exceeded the monthly budget limit. Open WalletFlow to review your recent transactions."
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleMonthlySummary(monthly: [Date: Double]) {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let calendar = Calendar.current
        let monthPrevius = calendar.date(byAdding: .month, value: -1, to: .now) ?? .now
        let monthComponent = calendar.dateComponents([.month, .year], from: monthPrevius)
        let month = calendar.date(from: monthComponent) ?? .now
        
        let monthValue = monthly[month]
        
        let content = UNMutableNotificationContent()
        content.title = "📊 Monthly Summary"
        content.body = "You spent \(monthValue?.currencyFormatter() ?? "" ) last month."
        
        
        
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.hour = 8
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "month_summary", content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .sound])
    }
}
