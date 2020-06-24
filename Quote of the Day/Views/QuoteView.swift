//
//  QuoteCardView.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/12/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class QuoteView: UIView {
	
	var quote: Quote? {
		didSet {
			if let quote = quote {
				quoteLabel.text = quote.quote
				authorLabel.text = "- \(quote.author ?? "")"
				dateLabel.text = formatDate(dateString: quote.date)
				categoryLabel.text = "\(String(describing: quote.category))"
				
				if let length = quote.length {
					if Int(length) ?? 0 > 400 {
						quoteLabel.font = UIFont(name: "Avenir-Book", size: 18)
					} else if Int(length) ?? 0 < 100 {
						quoteLabel.font = UIFont(name: "Avenir-Book", size: 22)
					}
					else {
						quoteLabel.font = UIFont(name: "Avenir-Book", size: 20)
					}
				}
			}
		}
	}
		
	// MARK: View Creation
	let cardView = CardView()
	
	var nativeAdPlaceHolder = UIView()
	
	var dateLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Avenir-Book", size: 14)
		label.textColor = .systemGray
		label.sizeToFit()
		
		return label
	}()
	
	let logoImageView = LogoImageView(frame: .zero)
	
	var categoryLabel: UILabel = {
		let label = UILabel()
		label.text = "  Inspirational  "
		label.textColor = Constants.accentColor
		label.font = UIFont(name: "AvenirNext-Medium", size: 13)
		
		return label
	}()
	
	var quoteLabel: UITextView = {
		let textView = UITextView()
		textView.font = UIFont(name: "Avenir-Book", size: 20)
		textView.textAlignment = .left
		textView.isEditable = false
		textView.textContainer.lineFragmentPadding = 0
		textView.backgroundColor = UIColor(named: "cardColor")
		
		return textView
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
	
	var shareButton = ShareButton()
	
	var favoriteButton = FavoriteButton()
	
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
		self.addSubview(nativeAdPlaceHolder)
		self.addSubview(cardView)
		self.addSubview(dateLabel)
		self.addSubview(logoImageView)
		self.addSubview(categoryLabel)
		self.addSubview(quoteLabel)
		self.addSubview(authorLabel)
		self.addSubview(lookupButton)
		self.addSubview(shareButton)
		self.addSubview(favoriteButton)
		self.addSubview(categoryButton)
	}
	
	func anchorSubviews() {
		
		nativeAdPlaceHolder.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 16, right: 12), size: .init(width: 0, height: 60))
		
		cardView.anchor(top: nativeAdPlaceHolder.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 16, left: 12, bottom: 16, right: 12))
		
		dateLabel.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 16, left: 32, bottom: 0, right: 32))
		
		logoImageView.anchor(top: cardView.topAnchor, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 17, left: 0, bottom: 0, right: 32), size: .init(width: 90, height: 16))
		
		categoryLabel.anchor(top: dateLabel.bottomAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 48, left: 32, bottom: 0, right: 0))
		
		quoteLabel.anchor(top: categoryLabel.bottomAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 8, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: 200))

		authorLabel.anchor(top: quoteLabel.bottomAnchor, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 32, left: 32, bottom: 0, right: 32))
		
		lookupButton.anchor(top: authorLabel.bottomAnchor, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
		
		shareButton.anchor(top: nil, leading: nil, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 24, right: 24), size: .init(width: 28, height: 28))
		
		favoriteButton.anchor(top: nil, leading: nil, bottom: cardView.bottomAnchor, trailing: shareButton.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 24, right: 24), size: .init(width: 28, height: 28))
		
		categoryButton.anchor(top: nil, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 24, right: 0), size: .init(width: 28, height: 28))
	}
}

private extension QuoteView {
	func formatDate(dateString: String) -> String {
		let dateFormatterGet = DateFormatter()
		dateFormatterGet.dateFormat = "yyyy-MM-dd"
		
		let dateFormatterPrint = DateFormatter()
		dateFormatterPrint.dateFormat = "dd MMM yyyy"
		
		if let date = dateFormatterGet.date(from: dateString) {
			return dateFormatterPrint.string(from: date)
		} else {
			return dateString
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
