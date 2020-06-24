//
//  UserDefaults.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 6/23/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import Foundation

extension UserDefaults {
	
	static func getDate() -> Date? {
		if let time = UserDefaults.standard.string(forKey: "notificationTime") {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "hh:mm"
			if let date = dateFormatter.date(from: time) {
				return date
			}
		}
		
		return nil
	}
	
	static func setDate(_ date: Date) {
		let components = Calendar.current.dateComponents([.hour, .minute,], from: date)
		let notificationTime = "\(String(format: "%02d", components.hour!)):\(String(format: "%02d", components.minute!))"
		UserDefaults.standard.set(notificationTime, forKey: "notificationTime")
	}
}
