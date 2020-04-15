//
//  QuoteEntity+CoreDataProperties.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 4/14/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//
//

import Foundation
import CoreData

extension QuoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuoteEntity> {
        return NSFetchRequest<QuoteEntity>(entityName: "QuoteEntity")
    }

    @NSManaged public var quote: String
    @NSManaged public var author: String?
    @NSManaged public var id: String
    @NSManaged public var category: String
    @NSManaged public var date: String
	
	func setProperties(quote: Quote) {
		self.id = quote.id
		self.quote = quote.quote
		self.author = quote.author
		self.category = String(describing: quote.category)
		self.date = quote.date
	}
	
	func toQuote() -> Quote {
		return Quote(id: id, quote: self.quote, length: nil, author: author, category: Category(rawValue: category)!, date: date)
	}
}
