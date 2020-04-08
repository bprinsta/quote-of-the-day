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

    override func viewDidLoad() {
        super.viewDidLoad()
		view = settingsView
		
    }
}
