//
//  Constants.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/18/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

struct Constants {
	static let blue =  #colorLiteral(red: 0.9167578816, green: 0.9742401242, blue: 0.9814491868, alpha: 1)
	static let darkBlue = #colorLiteral(red: 0, green: 0.7215686275, blue: 0.8274509804, alpha: 1)

	static let pink = #colorLiteral(red: 1, green: 0.9294117647, blue: 0.8980392157, alpha: 1)
	static let darkPink = #colorLiteral(red: 1, green: 0.4722140719, blue: 0.5490196078, alpha: 1)
	
	static let purple = #colorLiteral(red: 0.9294117647, green: 0.8980392157, blue: 1, alpha: 1)
	static let darkPurple = #colorLiteral(red: 0.5137254902, green: 0.3019607843, blue: 1, alpha: 1)

	static let backgroundColor = UIColor(named: "backgroundColor")
	static let accentColor = UIColor(named: "accentColor") ?? darkPurple
	
	static let dummyQuote = Quote(id: "000", quote: "If we’re not stretching, we’re not growing. If we’re not growing, we’re probably not fulfilling our potential. The only person in this room that knows your potential is you.", length: "173", author: "Kevin Turner", category: Category.inspire, date: "14 Feb 2020")
}
