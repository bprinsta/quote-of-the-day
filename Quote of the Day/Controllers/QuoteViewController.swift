//
//  QuoteViewController.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/11/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit
import WebKit

class QuoteViewController: UIViewController {
	
	var quoteView = QuoteView()
		
	var quote: Quote = Constants.dummyQuote {
		didSet {
			configureQuoteView()
		}
	}
	
	var selectedCategory = Category.love {
		didSet {
			fetchQuote()
		}
	}
	
	var webViewController = UIViewController()
	
	let webView = WKWebView()
	
	override func loadView() {
		view = quoteView
		
		fetchQuote()
		configureQuoteView()
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
		let textToShare = "Quote of the Day:\n\"\(quote.quote)\"\n\n- \(quote.author ?? "")"
		
//		let renderer = UIGraphicsImageRenderer(size: quoteView.bounds.size)
//		let image = renderer.image { ctx in
//			quoteView.drawHierarchy(in: quoteView.bounds, afterScreenUpdates: true)
//		}
		let objectsToShare: [Any] = [textToShare]
		let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
		activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
			
		self.present(activityVC, animated: true, completion: nil)
	}
	
	@objc func favoriteButtonClicked() {
		quoteView.toggleFavoriteButton()
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
	
	private func configureQuoteView() {
		// configure font size based off quote length
		quoteView.quoteLabel.text = quote.quote
		quoteView.authorLabel.text = "- \(quote.author ?? "")"
		quoteView.dateLabel.text = formatDate(dateString: quote.date)
		quoteView.categoryLabel.text = "\(String(describing: quote.category))"
	}
	
	private func formatDate(dateString: String) -> String {
		let dateFormatterGet = DateFormatter()
		dateFormatterGet.dateFormat = "yyyy-MM-dd"
		
		let dateFormatterPrint = DateFormatter()
		dateFormatterPrint.dateFormat = "dd MMM yyyy"
		
		if let date = dateFormatterGet.date(from: dateString) {
			return dateFormatterPrint.string(from: date)
		} else {
			return dateString
		}
	}
}

extension QuoteViewController: CategorySelectionDelegate {
	func didTapCategory(selected: Category) {
		selectedCategory = selected
	}
}

