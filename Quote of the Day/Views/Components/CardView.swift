//
//  CardView.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 3/21/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class CardView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = UIColor(named: "cardColor")
		self.layer.cornerRadius = 30
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}

