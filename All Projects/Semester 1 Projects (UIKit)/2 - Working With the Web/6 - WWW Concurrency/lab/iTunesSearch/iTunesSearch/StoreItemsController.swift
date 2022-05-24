//
//  StoreItemsController.swift
//  iTunesSearch
//
//  Created by Sam Hiatt  on 11/17/21.
//

import Foundation
import UIKit
class StoreItemController {
    
    func fetchItems(matching query: [String: String], completion: @escaping (Result<[StoreItem], Error>) -> Void) {
        var components2 = URLComponents(string: "https://itunes.apple.com/search")!
        components2.queryItems = query.map {
            URLQueryItem(name: $0.key, value: $0.value) }
        
        
        let task = URLSession.shared.dataTask(with: components2.url!) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                    completion(.success(searchResponse.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            }
        }
        task.resume()
    }
    
}
