//
//  Service.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 2/16/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
	
	static let shared = NetworkManager()
	
	func fetchQuote(about category: Category, completionHandler: @escaping (Result<[Quote], Error>) -> ()) {

		var urlComponents = URLComponents()
		urlComponents.scheme = "http"
		urlComponents.host = "quotes.rest"
		urlComponents.path = "/qod/"
		urlComponents.setQueryItems(with: ["category" : category.rawValue])
		
		guard let url = urlComponents.url else { return }
			
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let error = error {
				print("Error accessing quotes.rest/qod: \(error)")
				completionHandler(.failure(error))
				return
			}
			
			guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
				print("Error with the response, unexpected status code: \(String(describing: response))")
				return
			}
			
			guard let data = data else { return }

			do {
				let qotd = try JSONDecoder().decode(Root.self, from: data)
				completionHandler(.success(qotd.contents.quotes))
			}
			catch {
				print("JSONSerialization error:", error)
				completionHandler(.failure(error))
			}
		}.resume()
	}
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
