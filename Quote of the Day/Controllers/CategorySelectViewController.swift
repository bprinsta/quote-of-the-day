//
//  SelectCategoryViewController.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/23/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

protocol CategorySelectionDelegate {
	func didTapCategory(selected: Category)
}

class CategorySelectViewController: UIViewController {

	let selectCategoryView = CategorySelectView()
	
	var categoryDelegate: CategorySelectionDelegate!
	
	var categoryButtonMap = [UIButton:Category]()
	
	var iconMap: [Category: String] = {
		var map = [Category:String]()
		map[.inspire] = "🧠"
		map[.life] = "🌿"
		map[.art] = "🎨"
		map[.management] = "💼"
		map[.funny] = "🎭"
		map[.love] = "💌"
		map[.sports] = "🏅"
		map[.students] = "📚"
		
		return map
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view = selectCategoryView
		configureCategoryButtons()
    }
	
	@objc func categoryButtonClicked(_ sender: UIButton) {
		if let category = categoryButtonMap[sender] {
			categoryDelegate.didTapCategory(selected: category)
		}
		
		dismiss(animated: true, completion: nil)
	}
	
	private func configureCategoryButtons() {
		for index in Category.allCases.indices {
			
			// local category & button
			let category = Category.allCases[index]
			let button = selectCategoryView.categoryButtons[index]
			
			// set button title
			button.setTitle("\(iconMap[category] ?? "📖") \n" + String(describing: category), for: UIControl.State.normal)
			
			// map button to category type
			categoryButtonMap[button] = category
		}
		
		for button in selectCategoryView.categoryButtons {
			button.addTarget(self, action: #selector(categoryButtonClicked), for: .touchUpInside)
		}
	}

}
