//
//  SettingsView.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/19/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    let cardView = CardView()
	
	let scrollView = UIScrollView()
	
	let logoImage: UIImageView = {
		let imageView = UIImageView(image: #imageLiteral(resourceName: "in_app_icon"))
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = 8.0
		imageView.clipsToBounds = true
		return imageView
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Avenir-Medium", size: 24)
		label.text = "Quote of the Day"
		
		return label
	}()
	
	let versionInfoLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Avenir-Book", size: 12)
		label.textColor = .systemGray
		label.numberOfLines = 2
		label.textAlignment = .center
		
		return label
	}()
	
	let stackView: UIStackView = {
		let view = UIStackView()
		
		return view
	}()
	
	// MARK: Methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = Constants.backgroundColor
		
		addSubviews()
		anchorSubviews()
		configure()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		addSubviews()
		anchorSubviews()
		configure()
	}
	
	func configure() {
		if let dict = Bundle.main.infoDictionary {
			if let version = dict["CFBundleShortVersionString"] as? String,
				let bundleVersion = dict["CFBundleVersion"] as? String {
				versionInfoLabel.text = "Version: \(version)\n Build: \(bundleVersion)"
			}
		}
	}

	func addSubviews() {
		self.addSubview(cardView)
		cardView.addSubview(scrollView)
		scrollView.addSubview(titleLabel)
		scrollView.addSubview(logoImage)
		scrollView.addSubview(versionInfoLabel)
	}
	
	func anchorSubviews() {
		cardView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 16, right: 12))
		
		scrollView.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor)
		
		logoImage.anchor(top: cardView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 48, left: 0, bottom: 0, right:0), size: .init(width: 60, height: 60))
		logoImage.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
		
		titleLabel.anchor(top: logoImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
		titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
		
		versionInfoLabel.anchor(top: titleLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil)
		versionInfoLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
	}

}
