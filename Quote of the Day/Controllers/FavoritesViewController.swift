//
//  FavoritesViewController.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/11/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = Constants.backgroundColor
		
		let card = UIView()
		card.backgroundColor = .systemBackground
		card.layer.cornerRadius = 30
		card.clipsToBounds = true
		view.addSubview(card)
		card.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 16, right: 12))
		
		let label = UILabel()
		label.text = "Favorites"
		label.font = UIFont(name: "Avenir-Medium", size: 16)
		label.textColor = .black
		label.textAlignment = .center
		view.addSubview(label)
		label.anchor(top: card.topAnchor, leading: card.leadingAnchor, bottom: nil, trailing: card.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 8, right: 0))
		
		let tableView = UITableView()
		tableView.rowHeight = 60
		view.addSubview(tableView)
		tableView.anchor(top: label.bottomAnchor, leading: card.leadingAnchor, bottom: card.bottomAnchor, trailing: card.trailingAnchor, padding: .init(top: 12, left: 6, bottom: 12, right: 12))
    }
}
