//
//  FavoriteQuotesView.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 3/19/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class FavoriteQuotesView: UIView {

	let cardView = CardView()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Favorites"
		label.font = UIFont(name: "AvenirNext-Medium", size: 24)
		label.textColor = .black
		label.textAlignment = .center
		
		return label
	} ()
	
//	let favoritesCollectionView: UICollectionView = {
//		let collectionView = UICollectionView()
//
//		return collectionView
//
//	} ()
	
    override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = Constants.backgroundColor
		
		addSubviews()
		anchorSubviews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		addSubviews()
		anchorSubviews()
	}
	
	func addSubviews() {
		self.addSubview(cardView)
		self.addSubview(titleLabel)
//		self.addSubview(favoritesCollectionView)
	}
	
	func anchorSubviews() {
		cardView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 16, right: 12))
		
		titleLabel.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 8, right: 0))
		
//		favoritesCollectionView.anchor(top: titleLabel.bottomAnchor, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor, padding: .init(top: 12, left: 6, bottom: 12, right: 12))
	}
	
}
