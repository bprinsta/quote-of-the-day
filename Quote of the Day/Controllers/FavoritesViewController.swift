//
//  FavoritesViewController.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/11/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	var favoriteQuotes = [QuoteEntity]()
	
	var map = [QuoteCell: QuoteEntity]()
	
	let cellId = "cellId"
	
	let favoriteQuotesView = FavoriteQuotesView()
		
    override func viewDidLoad() {
        super.viewDidLoad()
		view = favoriteQuotesView
		
		favoriteQuotesView.collectionView.delegate = self
		favoriteQuotesView.collectionView.dataSource = self
		favoriteQuotesView.collectionView.register(QuoteCell.self, forCellWithReuseIdentifier: cellId)
		
		getFavorites()
		
		configureQuoteButtons()
    }
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return favoriteQuotes.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! QuoteCell
		
		cell.quote = favoriteQuotes[indexPath.item]
		map[cell] = cell.quote
		//cell.favoriteButton.addTarget(self, action: #selector(deleteFavorite), for: .touchUpInside)
		cell.shareButton.addTarget(self, action: #selector(shareButtonClicked), for: .touchUpInside)
		
		// need to map buttons to specfic senders yada ydada
		return cell
	}
		
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize.init(width: view.frame.width - 24, height: 180)
	}
	
	func configureQuoteButtons() {
		
	}
	
	func saveFavorite(quote: Quote) {
		let quoteEntity = QuoteEntity(context: CoreDataManager.managedObjectContext)
		
		quoteEntity.setProperties(quote: quote)
		CoreDataManager.saveContext()
		favoriteQuotes.append(quoteEntity)
	}
	
	func deleteFavorite(quote: Quote) {
		let entities = favoriteQuotes.filter {$0.id == quote.id}
		let quoteEntity = entities[0]
		
		CoreDataManager.managedObjectContext.delete(quoteEntity)
		CoreDataManager.saveContext()
		
		if let index = favoriteQuotes.firstIndex(of: quoteEntity) {
				favoriteQuotes.remove(at: index)
		}
	}
	
	func getFavorites() {
		let fetchRequest: NSFetchRequest<QuoteEntity> = QuoteEntity.fetchRequest()
		do {
			let quotes = try CoreDataManager.managedObjectContext.fetch(fetchRequest)
			self.favoriteQuotes = quotes
			favoriteQuotesView.collectionView.reloadData()
		} catch {
			
		}
	}
}

extension FavoritesViewController: FavoriteDelegate {
	func addFavorite(_ quote: Quote) {
		saveFavorite(quote: quote)
		favoriteQuotesView.collectionView.reloadData()
	}
	
	func removeFavorite(_ quote: Quote) {
		deleteFavorite(quote: quote)
		favoriteQuotesView.collectionView.reloadData()
	}
}

extension FavoritesViewController {
	@objc func shareButtonClicked(index: Int) {
		let quote = Constants.dummyQuote
		print(index)
		
		let textToShare = """
		Quote of the Day:
		
		\"\(quote.quote)\"
		
		- \(quote.author ?? "")
		"""
		
		let imageView = ShareQuoteImageView()
		imageView.quote = quote
		
		let renderer = UIGraphicsImageRenderer(size: imageView.bounds.size)
		let image = renderer.image { ctx in
			imageView.drawHierarchy(in: imageView.bounds, afterScreenUpdates: true)
		}
		
		let objectsToShare: [Any] = [image, textToShare]
		let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
		activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
			
		self.present(activityVC, animated: true, completion: nil)
	}
}

