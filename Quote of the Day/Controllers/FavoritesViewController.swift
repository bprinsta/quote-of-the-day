//
//  FavoritesViewController.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/11/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	var favoriteQuotes = [Quote]()
	
	let cellId = "cellId"
	
	let favoriteQuotesView = FavoriteQuotesView()
		
    override func viewDidLoad() {
        super.viewDidLoad()
		view = favoriteQuotesView
		
		favoriteQuotesView.collectionView.delegate = self
		favoriteQuotesView.collectionView.dataSource = self
		favoriteQuotesView.collectionView.register(QuoteCell.self, forCellWithReuseIdentifier: cellId)
    }
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return favoriteQuotes.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! QuoteCell
		
		cell.quote = favoriteQuotes[indexPath.item]
		
		// cell.maxWidth = view.frame.width - 24
		
		return cell
	}
		
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize.init(width: view.frame.width - 24, height: 180)
	}
}

extension FavoritesViewController: FavoriteDelegate {
	func addFavorite(_ quote: Quote) {
		favoriteQuotes.append(quote)
		favoriteQuotesView.collectionView.reloadData()
	}
	
	func removeFavorite(_ quote: Quote) {
		if let index = favoriteQuotes.firstIndex(of: quote) {
			favoriteQuotes.remove(at: index)
		}
		favoriteQuotesView.collectionView.reloadData()
	}
}

