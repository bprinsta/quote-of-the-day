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

	
	let pickerLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "Avenir-Book", size: 14)
		label.textColor = .systemGray
		label.textAlignment = .left
		label.text = "Select you desired notification time"
		
		return label
	}()
	
	let notificationTimePicker: UIDatePicker = {
		let datePicker = UIDatePicker()
		datePicker.datePickerMode = .time
		datePicker.minuteInterval = 15
		
		return datePicker
	} ()
	
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
		cardView.addSubview(titleLabel)
		cardView.addSubview(logoImage)
		cardView.addSubview(versionInfoLabel)
		cardView.addSubview(pickerLabel)
		cardView.addSubview(notificationTimePicker)
	}
	
	func anchorSubviews() {
		cardView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 16, right: 12))
		
		logoImage.anchor(top: cardView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 48, left: 0, bottom: 0, right:0), size: .init(width: 60, height: 60))
		logoImage.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
		
		titleLabel.anchor(top: logoImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
		titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
		
		versionInfoLabel.anchor(top: titleLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil)
		versionInfoLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
		
		pickerLabel.anchor(top: versionInfoLabel.bottomAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 40, left: 16, bottom: 0, right: 16))
		
		notificationTimePicker.anchor(top: pickerLabel.bottomAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 16, right: 16))
	}

}
