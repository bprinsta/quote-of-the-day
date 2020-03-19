//
//  ViewController.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/22/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		UITabBar.appearance().tintColor = Constants.accentColor
		self.viewControllers = [createQuoteViewController(), createFavoritesViewController(), createCalenderViewController(), createSettingsViewController()]
    }
	
	func createQuoteViewController() -> QuoteViewController {
		let quoteVC = QuoteViewController()
		quoteVC.tabBarItem = UITabBarItem(title: "Quote", image: #imageLiteral(resourceName: "icons8-quote-30"), tag: 0)

		return quoteVC
	}

	func createFavoritesViewController() -> FavoritesViewController {
		let favoritesVC = FavoritesViewController()
		favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "icons8-bookmark-30"), tag: 1)

		return favoritesVC
	}

	func createCalenderViewController() -> CalenderViewController{
		let calenderVC = CalenderViewController()
		calenderVC.tabBarItem = UITabBarItem(title: "Calendar", image: #imageLiteral(resourceName: "icons8-calendar-31-30"), tag: 2)

		return calenderVC
	}

	func createSettingsViewController() -> SettingsViewController {
		let settingsVC = SettingsViewController()
		settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "icons8-settings-30"), tag: 3)

		return settingsVC
	}

}
