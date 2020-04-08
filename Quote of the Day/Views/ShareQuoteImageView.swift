//
//  ShareQuoteImageView.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 3/19/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class ShareQuoteImageView: UIView {
	
	var quote: Quote? {
		didSet {
			if let quote = quote {
				quoteLabel.text = "\"\(quote.quote)\""
				authorLabel.text = "- \(quote.author ?? "")"
				categoryLabel.text = "#\(String(describing: quote.category))"
			}
		}
	}
	
	let logoImageView: LogoImageView = {
		let logoImageView = LogoImageView(frame: .zero)
		logoImageView.setImageColor(color: .black)
		
		return logoImageView
	}()
	
	var categoryLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = UIFont(name: "Avenir-Light", size: 12)
		
		return label
	}()
	
	var quoteLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Avenir-Book", size: 14)
		label.textAlignment = .center
		label.numberOfLines = 0
		
		return label
	}()
	
	var authorLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Avenir-LightOblique", size: 12)
		label.textAlignment = .left
		label.numberOfLines = 0
		
		return label
	}()
	
	// MARK: Methods
	override init(frame: CGRect) {
		super.init(frame: .init(x: 0, y: 0, width: 340, height: 340))
		self.backgroundColor = Constants.backgroundColor
		
		addSubviews()
		anchorSubviews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func addSubviews(){
		self.addSubview(logoImageView)
		self.addSubview(categoryLabel)
		self.addSubview(quoteLabel)
		self.addSubview(authorLabel)
	}
	
	func anchorSubviews() {
		logoImageView.anchor(top: self.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 64, left: 0, bottom: 0, right: 0), size: .init(width: 135, height: 24))
		logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		
		quoteLabel.anchor(top: logoImageView.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 24, left: 32, bottom: 0, right: 32))
		
		categoryLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 24, right: 0))
		
		authorLabel.anchor(top: nil, leading: nil, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 24, right: 24))
	}
}
