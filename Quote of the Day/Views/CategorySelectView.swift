//
//  SelectCategoryView.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/23/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class CategorySelectView: UIView {
	
	static var iconMap: [Category: String] = {
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

	var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Categories"
		label.textColor = .black
		label.textAlignment = .center
		
		label.font = UIFont(name: "AvenirNext-Medium", size: 24)
		return label
	}()
	
	var categoryButtons: [UIButton] = {
		var buttons = [UIButton]()
		
		for category in Category.allCases {
			let button = UIButton()
			button.backgroundColor = .white
			
			let style = NSMutableParagraphStyle()
			style.alignment = .center
			style.lineBreakMode = .byWordWrapping
			
			let fontBig = UIFont(name: "Avenir-Medium", size: 56)
			let fontSmall = UIFont(name: "Avenir-Medium", size: 18)

			let dict1:[NSAttributedString.Key:Any] = [
				NSAttributedString.Key.font:fontBig as Any,
				NSAttributedString.Key.paragraphStyle:style
			]

			let dict2:[NSAttributedString.Key:Any] = [
				NSAttributedString.Key.font:fontSmall as Any,
				NSAttributedString.Key.paragraphStyle:style,
				NSAttributedString.Key.foregroundColor: UIColor.gray
			]

			let attString = NSMutableAttributedString()
			attString.append(NSAttributedString(string: CategorySelectView.iconMap[category]!, attributes: dict1))
			attString.append(NSAttributedString(string: "\n"))
			attString.append(NSAttributedString(string: String(describing: category), attributes: dict2))

			button.setAttributedTitle(attString, for: .normal)
			
			button.titleLabel?.numberOfLines = 2
			button.titleLabel?.lineBreakMode = .byWordWrapping
			
			button.layer.cornerRadius = 8
			button.clipsToBounds = true
			
			buttons.append(button)
		}
		
		return buttons
	}()
	
	var horizontalStackViews: [UIStackView] = {
		var stackViews = [UIStackView]()
		
		for i in 0 ..< 4 {
			let stackView = UIStackView()
			stackView.axis = .horizontal
			stackView.distribution = .fillEqually
			stackView.alignment = .fill
			stackView.spacing = 24
			
			stackViews.append(stackView)
		}
		
		return stackViews
	}()
	
	var verticalStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .fillEqually
		stackView.alignment = .fill
		stackView.spacing = 24

		return stackView
	} ()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = Constants.backgroundColor
		
		addSubviews()
		anchorSubviews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		backgroundColor = Constants.backgroundColor
		
		addSubviews()
		anchorSubviews()
	}
	
	func addSubviews() {
		addSubview(titleLabel)
		addSubview(verticalStackView)
		for index in horizontalStackViews.indices {
			let stackView = horizontalStackViews[index]
			
			verticalStackView.addArrangedSubview(stackView)
			stackView.addArrangedSubview(categoryButtons[index * 2])
			stackView.addArrangedSubview(categoryButtons[index * 2 + 1])
			
		}
	}
	
	func anchorSubviews() {
		titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 30))
		
		verticalStackView.anchor(top: titleLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 16, right: 16))
	}
}
