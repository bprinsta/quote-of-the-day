//
//  QuoteModel.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/12/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import Foundation

struct Quote: Decodable, Hashable {
	let id: String
	let quote: String
	let length: String?
	let author: String?
	let category: Category
	let date: String
	let title: String?
	let background: URL?
	let favorited: Bool?
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}

}

struct Root: Decodable {
	let contents: Contents
}

struct Contents: Decodable {
	let quotes: [Quote]
}

enum Category: String, Decodable, CaseIterable {
	case inspire = "inspire"
	case management = "management"
	case sports = "sports"
	case life = "life"
	case funny = "funny"
	case love = "love"
	case art = "art"
	case students = "students"
}

extension Category: CustomStringConvertible {
	var description: String {
		switch self {
		case Category.inspire:
			return "Inspirational"
		case .management:
			return "Management"
		case .sports:
			return "Sports"
		case .life:
			return "Life"
		case .funny:
			return "Humorous"
		case .love:
			return "Love"
		case .art:
			return "Art"
		case .students:
			return "Education"
		}
	}
}
