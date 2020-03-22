//
//  LogoLabel.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 3/21/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class LogoImageView: UIImageView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		let image = UIImage(named: "app_title") as UIImage?
		self.image = image
		self.contentMode = .scaleAspectFit
		self.setImageColor(color: .systemGray)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}

