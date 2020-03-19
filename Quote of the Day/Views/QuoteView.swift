//
//  QuoteCardView.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/12/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class QuoteView: UIView {
	
	// MARK: View Creation
	let cardView: UIView = {
		let view = UIView()
		view.backgroundColor = .systemBackground
		view.layer.cornerRadius = 30
		
		return view
	}()
	
	var dateLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Avenir-Book", size: 14)
		label.textColor = .systemGray
		label.sizeToFit()
		
		return label
	}()
	
	let logoLabel: UIImageView = {
		let image = UIImage(named: "app_title") as UIImage?
		let imageView = UIImageView(image: image)
		imageView.contentMode = .scaleAspectFit
		imageView.setImageColor(color: .systemGray)
		
		return imageView
	}()
	
	var categoryLabel: UILabel = {
		let label = UILabel()
		label.text = "  Inspirational  "
		label.textColor = Constants.accentColor
		label.font = UIFont(name: "AvenirNext-Medium", size: 13)
		
		return label
	}()
	
	var quoteLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Avenir-Book", size: 20)
		label.textAlignment = .left
		label.numberOfLines = 0
		
		return label
	}()
	
	var authorLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Avenir-LightOblique", size: 14)
		label.textAlignment = .left
		label.numberOfLines = 0
		
		return label
	}()
	
	var lookupButton: UIButton = {
		let button = UIButton()
		button.setTitle("🔍 Look up author with Google", for: UIControl.State.normal)
		button.setTitleColor(Constants.accentColor, for: UIControl.State.normal)
		button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 12)
		
		return button
	}()
	
	var shareButton: UIButton = {
		let image = #imageLiteral(resourceName: "icons8-share-rounded-30")
		let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
		button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
		button.setImage(image, for: UIControl.State.normal)
		button.setImageColor(color: Constants.accentColor)
		
		return button
	}()
	
	var favoriteButton: ToggleButton = {
		let favoriteIcon = #imageLiteral(resourceName: "icons8-heart-24")
		let button = ToggleButton()
		button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
		button.setImage(favoriteIcon, for: UIControl.State.normal)
		button.setImageColor(color: Constants.accentColor)
		return button
	}()
	
	var categoryButton: UIButton = {
		let categoryIcon = #imageLiteral(resourceName: "icons8-squared-menu-50")
		let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
		button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
		button.setImage(categoryIcon, for: UIControl.State.normal)
		button.setImageColor(color: Constants.accentColor)
		
		return button
	}()
	
	// MARK: Methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = Constants.backgroundColor
		
		addSubviews()
		anchorSubviews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		addSubviews()
		anchorSubviews()
	}
	
	func addSubviews(){
		self.addSubview(cardView)
		self.addSubview(dateLabel)
		self.addSubview(logoLabel)
		self.addSubview(categoryLabel)
		self.addSubview(quoteLabel)
		self.addSubview(authorLabel)
		self.addSubview(lookupButton)
		self.addSubview(shareButton)
		self.addSubview(favoriteButton)
		self.addSubview(categoryButton)
	}
	
	func anchorSubviews() {
		cardView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 16, right: 12))
		
		dateLabel.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 16, left: 32, bottom: 0, right: 32))
		
		logoLabel.anchor(top: cardView.topAnchor, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 17, left: 0, bottom: 0, right: 32), size: .init(width: 90, height: 16))
		
		categoryLabel.anchor(top: dateLabel.bottomAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 48, left: 32, bottom: 0, right: 0))
		
		quoteLabel.anchor(top: categoryLabel.bottomAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 8, left: 32, bottom: 0, right: 32))
		
		authorLabel.anchor(top: quoteLabel.bottomAnchor, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 32, left: 32, bottom: 0, right: 32))
		
		lookupButton.anchor(top: authorLabel.bottomAnchor, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
		
		shareButton.anchor(top: nil, leading: nil, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 24, right: 24), size: .init(width: 28, height: 28))
		
		favoriteButton.anchor(top: nil, leading: nil, bottom: cardView.bottomAnchor, trailing: shareButton.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 24, right: 24), size: .init(width: 28, height: 28))
		
		categoryButton.anchor(top: nil, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 24, right: 0), size: .init(width: 28, height: 28))
	}
	
	func toggleFavoriteButton() {
		if favoriteButton.isOn {
			favoriteButton.setImage(#imageLiteral(resourceName: "icons8-heart-24"), for: UIControl.State.normal)
			favoriteButton.setImageColor(color: Constants.accentColor)
			favoriteButton.isOn = false
		} else {
			favoriteButton.setImage(#imageLiteral(resourceName: "icons8-heart-fill-24"), for: UIControl.State.normal)
			favoriteButton.setImageColor(color: Constants.accentColor)
			favoriteButton.isOn = true
		}
	}
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

extension UIButton {
  func setImageColor(color: UIColor) {
	let templateImage = self.image(for: UIControl.State.normal)?.withRenderingMode(.alwaysTemplate)
	self.setImage(templateImage, for: UIControl.State.normal)
    self.tintColor = color
  }
}
