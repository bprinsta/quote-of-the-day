//
//  ToggleButton.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/22/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class ToggleButton: UIButton {
    var isOn = false

	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}
