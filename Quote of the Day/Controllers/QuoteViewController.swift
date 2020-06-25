//
//  QuoteViewController.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/11/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit
import WebKit
import CoreData
import GoogleMobileAds

protocol FavoriteDelegate {
	func addFavorite(_ quote: Quote)
	
	func removeFavorite(_ quote: Quote)
}

class QuoteViewController: UIViewController, GADUnifiedNativeAdDelegate {
	
	/// The ad loader. You must keep a strong reference to the GADAdLoader during the ad loading
	/// process.
	var adLoader: GADAdLoader!

	/// The native ad view that is being presented.
	var nativeAdView: GADUnifiedNativeAdView!

	/// The ad unit ID.
	let adUnitID = Constants.realAdUnitId
	
	var quoteView = QuoteView()
		
	var quote: Quote = Constants.dummyQuote {
		didSet {
			quoteView.quote = quote
			
			let results = favoriteQuotes.filter { $0.id == quote.id }
			
			if results.isEmpty {
				quoteView.favoriteButton.isOn = false
			} else {
				quoteView.favoriteButton.isOn = true
			}
		}
	}
	
	var selectedCategory = Category.inspire {
		didSet {
			fetchQuote()
		}
	}
	
	var favoriteDelegate: FavoriteDelegate!
	
	var favoriteQuotes = [Quote]()
	
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
		
		guard let nibObjects = Bundle.main.loadNibNamed("NativeAdView", owner: nil, options: nil),
		  let adView = nibObjects.first as? GADUnifiedNativeAdView else {
			assert(false, "Could not load nib file for adView")
			return
		}
		setAdView(adView)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		loadAd()
	}
	
	// MARK: Admob Config
	func setAdView(_ view: GADUnifiedNativeAdView) {
		// Remove the previous ad view.
		nativeAdView = view
		quoteView.nativeAdPlaceHolder.addSubview(nativeAdView)
		nativeAdView.translatesAutoresizingMaskIntoConstraints = false
		
		// Layout constraints for positioning the native ad view to stretch the entire width and height
		// of the nativeAdPlaceholder.
		let viewDictionary = ["_nativeAdView": nativeAdView!]
		self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[_nativeAdView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary))
		self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[_nativeAdView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary))
		
		// native adview styling
		nativeAdView.layer.cornerRadius = 16
		nativeAdView.iconView?.layer.cornerRadius = 8
		nativeAdView.callToActionView?.layer.cornerRadius = 8
		nativeAdView.callToActionView?.clipsToBounds = true
		nativeAdView.callToActionView?.backgroundColor = Constants.darkPurple
	}
	
	/// Refreshes the native ad.
	func loadAd() {
		let adMediaOptions = GADNativeAdMediaAdLoaderOptions()
		adMediaOptions.mediaAspectRatio = .square
		
		adLoader = GADAdLoader(adUnitID: adUnitID, rootViewController: self,
							   adTypes: [ .unifiedNative ], options: [adMediaOptions])
		adLoader.delegate = self
		adLoader.load(GADRequest())
	}
	
	func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
		// The adLoader has finished loading ads, and a new request can be sent.
	}
	
	// MARK: Fetch Quote
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
	
	// MARK: Button Actions
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
		let categoryVC = CategorySelectViewController()
		
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

extension QuoteViewController {
	func getFavorites() {
		let fetchRequest: NSFetchRequest<QuoteEntity> = QuoteEntity.fetchRequest()
		do {
			let quotes = try CoreDataManager.managedObjectContext.fetch(fetchRequest)
			self.favoriteQuotes = quotes.map{ $0.toQuote() }
		} catch {
			
		}
	}
}

// MARK: AdLoaderDelegate
extension QuoteViewController: GADUnifiedNativeAdLoaderDelegate {
	func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
		 nativeAdView.nativeAd = nativeAd
		
		// Set ourselves as the native ad delegate to be notified of native ad events.
		nativeAd.delegate = self

		// Populate the native ad view with the native ad assets.
		// The headline and mediaContent are guaranteed to be present in every native ad.
		(nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
		
		(nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
		(nativeAdView.callToActionView as? UIButton)?.titleEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
		(nativeAdView.callToActionView as? UIButton)?.titleLabel?.numberOfLines = 2
		nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil

		(nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
		nativeAdView.iconView?.isHidden = nativeAd.icon == nil
		
		(nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
		nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil
		
		// In order for the SDK to process touch events properly, user interaction should be disabled.
		nativeAdView.callToActionView?.isUserInteractionEnabled = false
	}
}

