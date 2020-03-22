//
//  FavoriteButton.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 3/21/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    
	var isOn = false {
		didSet {
			if isOn {
				self.setImage(#imageLiteral(resourceName: "icons8-heart-fill-24"), for: UIControl.State.normal)
				self.setImageColor(color: Constants.accentColor)
			} else {
				self.setImage(#imageLiteral(resourceName: "icons8-heart-24"), for: UIControl.State.normal)
				self.setImageColor(color: Constants.accentColor)
			}
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		let favoriteIcon = #imageLiteral(resourceName: "icons8-heart-24")
		self.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
		self.setImage(favoriteIcon, for: UIControl.State.normal)
		self.setImageColor(color: Constants.accentColor)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}
