//
//  ShareButton.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 3/21/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class ShareButton: UIButton {
	
	var quoteEntity: QuoteEntity?

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		let image = #imageLiteral(resourceName: "icons8-share-rounded-30")
		self.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
		self.setImage(image, for: UIControl.State.normal)
		self.setImageColor(color: Constants.accentColor)
			
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

}
