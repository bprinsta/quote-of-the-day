//
//  Cell.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 3/21/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class QuoteCell: BaseCell {
	
	var quote: Quote? {
		didSet {
			if let quote = quote {
				quoteText.text = "\"\(quote.quote)\""
				authorLabel.text =  "- \(quote.author ?? "")"
				categoryLabel.text = "\(String(describing: quote.category))"
			}
		}
	}
	 
	let quoteText: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Avenir-Book", size: 16)
		label.textAlignment = .left
		label.textColor = .black
		label.numberOfLines = 0
		
		return label
	} ()
	
	var categoryLabel: UILabel = {
		let label = UILabel()
		label.text = "  Inspirational  "
		label.textColor = Constants.accentColor
		label.font = UIFont(name: "AvenirNext-Medium", size: 13)
		
		return label
	}()
	
	var authorLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Avenir-LightOblique", size: 14)
		label.textAlignment = .left
		label.numberOfLines = 0
		
		return label
	}()
	
	var favoriteButton: FavoriteButton = {
		let button = FavoriteButton()
		button.isOn = true
		
		return button
	}()
	
	var shareButton = ShareButton()
	
	override func addSubviews() {
		self.addSubview(quoteText)
		self.addSubview(categoryLabel)
		self.addSubview(authorLabel)
		self.addSubview(favoriteButton)
		self.addSubview(shareButton)
	}
	
	override func anchorSubviews() {
		categoryLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 24, left: 24, bottom: 0, right: 24))
		
		quoteText.anchor(top: categoryLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 8, left: 24, bottom: 0, right: 24))
		
		authorLabel.anchor(top: nil, leading: nil, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 16, right: 24))
		
		favoriteButton.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 16, right: 0), size: .init(width: 25, height: 25))
		
		shareButton.anchor(top: nil, leading: favoriteButton.trailingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 16, right: 0), size: .init(width: 25, height: 25))
	}
}

class BaseCell: UICollectionViewCell {
	
	var maxWidthConstraint: NSLayoutConstraint! {
		didSet {
			maxWidthConstraint.isActive = false
		}
	}
	
	var maxWidth: CGFloat? = nil {
		didSet {
			guard let maxWidth = maxWidth else {
				return
			}
			maxWidthConstraint.isActive = true
			maxWidthConstraint.constant = maxWidth
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupViews()
		addSubviews()
		anchorSubviews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		addSubviews()
		anchorSubviews()
	}
	
	func setupViews() {
		backgroundColor = .systemBackground
		self.layer.cornerRadius = 20
		self.layer.masksToBounds = true
	}
	
	func addSubviews() {
		
	}
	
	func anchorSubviews() {
		
	}
}
