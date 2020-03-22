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
	
	func setupData() {
		favoriteQuotes = [Constants.dummyQuote, Constants.dummyQuote]
	}
	
	let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		//layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 16
		
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		// collection.translatesAutoresizingMaskIntoConstraints = false
		collection.backgroundColor = Constants.backgroundColor
		// collection.isScrollEnabled = true
		collection.alwaysBounceVertical = true
		return collection
	 }()
	
	var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Favorites"
		label.textColor = .black
		label.textAlignment = .center
		
		label.font = UIFont(name: "AvenirNext-Medium", size: 24)
		return label
	}()
		
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = Constants.backgroundColor
		
		view.addSubview(titleLabel)
		view.addSubview(collectionView)
		titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
		
		collectionView.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
		
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(QuoteCell.self, forCellWithReuseIdentifier: cellId)
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
		collectionView.reloadData()
	}
	
	func removeFavorite(_ quote: Quote) {
		if let index = favoriteQuotes.firstIndex(of: quote) {
			favoriteQuotes.remove(at: index)
		}
		collectionView.reloadData()
	}
}

