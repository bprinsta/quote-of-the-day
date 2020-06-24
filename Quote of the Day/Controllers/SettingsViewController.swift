//
//  SettingsViewController.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/11/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

	lazy var settingsView = SettingsView()
	
	let fields = ["Remove Ads", "Daily notifications", "Rate this app", "Feedback"]
		
	override func viewDidLoad() {
		super.viewDidLoad()
		view = settingsView
		
		if let date = UserDefaults.getDate() {
			settingsView.notificationTimePicker.setDate(date, animated: false)
		}
		
		settingsView.notificationTimePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
	}
	
	@objc func dateChanged(_ sender: UIDatePicker) {
		UserDefaults.setDate(sender.date)
	}
}
