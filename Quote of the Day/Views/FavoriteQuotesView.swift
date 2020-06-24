//
//  FavoriteQuotesView.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 3/19/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class FavoriteQuotesView: UIView {

	let collectionView: UICollectionView = {
		let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(400)
        )
		
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 16

        let layout = UICollectionViewCompositionalLayout(section: section)
		
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.backgroundColor = Constants.backgroundColor
		collection.alwaysBounceVertical = true
		return collection
	 }()
	
	var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Favorites"
		label.textAlignment = .center
		
		label.font = UIFont(name: "AvenirNext-Medium", size: 24)
		return label
	}()
	
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
		self.addSubview(titleLabel)
		self.addSubview(collectionView)
	}
	
	func anchorSubviews() {
		titleLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
		
		collectionView.anchor(top: titleLabel.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
	}
	
}
