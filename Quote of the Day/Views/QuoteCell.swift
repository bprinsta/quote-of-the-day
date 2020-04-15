//
//  Cell.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 3/21/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class QuoteCell: BaseCell {
	
	var quote: QuoteEntity? {
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
		contentView.addSubview(quoteText)
		contentView.addSubview(categoryLabel)
		contentView.addSubview(authorLabel)
		contentView.addSubview(favoriteButton)
		contentView.addSubview(shareButton)
	}
	
	override func anchorSubviews() {
		categoryLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 24, left: 24, bottom: 0, right: 24))
		
		quoteText.anchor(top: categoryLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 8, left: 24, bottom: 16, right: 24))
		
		authorLabel.anchor(top: quoteText.bottomAnchor, leading: nil, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 16, right: 24))
		
		favoriteButton.anchor(top: nil, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 16, right: 0), size: .init(width: 25, height: 25))
		
		shareButton.anchor(top: nil, leading: favoriteButton.trailingAnchor, bottom: contentView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 16, right: 0), size: .init(width: 25, height: 25))
		
		// contentView.anchor(top: nil, leading: nil, bottom: authorLabel.bottomAnchor, trailing: nil)
	}
}

class BaseCell: UICollectionViewCell {
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
		backgroundColor = UIColor(named: "cardColor")
		self.layer.cornerRadius = 20
		self.layer.masksToBounds = true
	}
	
	func addSubviews() {}
	
	func anchorSubviews() {
	}
}
