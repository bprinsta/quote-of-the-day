//
//  Notifications.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 3/19/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import Foundation
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
	
	let notificationCenter = UNUserNotificationCenter.current()
		
	func notificationRequest() {
		let options: UNAuthorizationOptions = [.alert, .sound, .badge]
		
		notificationCenter.requestAuthorization(options: options) {
			(didAllow, error) in
			if !didAllow {
				print("User has declined notifications")
			}
		}
	}
	
	func scheduleNotification() {
		let content = UNMutableNotificationContent()
			
		// here all we want is maybe some singleton value of the quote
		content.body = "Check out your new Quote of the Day!"
		
		content.sound = UNNotificationSound.default
		content.badge = 1
		
		var dateComponents = DateComponents(calendar: Calendar.current, hour: 9, minute: 0)
		
		if let time = UserDefaults.standard.string(forKey: "notificationTime") {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "hh:mm"
			if let date = dateFormatter.date(from: time) {
				dateComponents = Calendar.current.dateComponents([.hour, .minute,], from: date)
			}
		}
		
		print(dateComponents)
		
		let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
		
		let request = UNNotificationRequest(identifier: "Daily Notification", content: content, trigger: trigger)
		
		notificationCenter.add(request) { (error) in
			if error != nil {
				// Handle any errors.
			}
		}
	}
}
