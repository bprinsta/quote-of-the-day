//
//  QuoteViewController.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/11/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit
import WebKit

protocol FavoriteDelegate {
	
	func addFavorite(_ quote: Quote)
	
	func removeFavorite(_ quote: Quote)
}

class QuoteViewController: UIViewController {
	
	var quoteView = QuoteView()
		
	var quote: Quote = Constants.dummyQuote {
		didSet {
			quoteView.quote = quote
		}
	}
	
	var selectedCategory = Category.inspire {
		didSet {
			fetchQuote()
		}
	}
	
	var favoriteDelegate: FavoriteDelegate!
	
	var webViewController = UIViewController()
	
	let webView = WKWebView()
	
	override func loadView() {
		view = quoteView
		
		fetchQuote()
		quoteView.quote = quote
		configureButtons()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
	}
	
	fileprivate func fetchQuote() {
		NetworkManager.shared.fetchQuote(about: selectedCategory) { (res) in
			switch res {
			case .failure(let err):
				print("Failed to fetch quote:", err)
			case .success(let quotes):
				DispatchQueue.main.async() {
					self.quote = quotes[0]
				}
			}
		}
	}
	
	@objc func lookupAuthorButtonClicked() {
		if let author = quote.author {
			let safeURL = author.replacingOccurrences(of: " ", with: "+")
			if let url = URL(string: "https://www.google.com/search?q=\(safeURL)") {
				let request = URLRequest(url: url)
				webView.load(request)
				webViewController.view = webView
				
				self.present(webViewController, animated: true, completion: nil)
			}
		}
	}
	
	@objc func shareButtonClicked() {
		let textToShare = """
		Quote of the Day:
		
		\"\(quote.quote)\"
		
		- \(quote.author ?? "")
		"""
		
		let imageView = ShareQuoteImageView()
		
		let renderer = UIGraphicsImageRenderer(size: imageView.bounds.size)
		let image = renderer.image { ctx in
			imageView.drawHierarchy(in: imageView.bounds, afterScreenUpdates: true)
		}
		
		let objectsToShare: [Any] = [image, textToShare]
		let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
		activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
			
		self.present(activityVC, animated: true, completion: nil)
	}
	
	@objc func favoriteButtonClicked() {
		if quoteView.favoriteButton.isOn {
			quoteView.favoriteButton.isOn = false
			favoriteDelegate.removeFavorite(quote)
		} else {
			quoteView.favoriteButton.isOn = true
			favoriteDelegate.addFavorite(quote)
		}
	}
	
	@objc func categoryButtonClicked() {
		let categoryVC = SelectCategoryViewController()
		
		categoryVC.categoryDelegate = self
        self.present(categoryVC, animated: true, completion: nil)
	}
	
	private func configureButtons() {
		quoteView.lookupButton.addTarget(self, action: #selector(lookupAuthorButtonClicked), for: .touchUpInside)
		quoteView.shareButton.addTarget(self, action: #selector(shareButtonClicked), for: .touchUpInside)
		quoteView.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
		quoteView.categoryButton.addTarget(self, action: #selector(categoryButtonClicked), for: .touchUpInside)
	}
}

extension QuoteViewController: CategorySelectionDelegate {
	func didTapCategory(selected: Category) {
		selectedCategory = selected
	}
}

