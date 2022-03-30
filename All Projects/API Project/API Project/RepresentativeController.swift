//
//  RepresentativeController.swift
//  API Project
//
//  Created by Sam Hiatt  on 11/29/21.
//

import Foundation
import UIKit
class RepresentativeController {
func fetchItems(matching query: [String: String], completion: @escaping (Result<[Representative], Error>) -> Void) {
    var components2 = URLComponents(string: "https://whoismyrepresentative.com/getall_mems.php?zip=31023")!
    components2.queryItems = query.map {
        URLQueryItem(name: $0.key, value: $0.value) }
    
    
    let task = URLSession.shared.dataTask(with: components2.url!) { (data, response, error) in
        
        if let error = error {
            completion(.failure(error))
        } else if let data = data {
            do {
                let decoder = JSONDecoder()
                let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                //  let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                completion(.success(searchResponse.results))
            } catch {
                completion(.failure(error))
            }
        }
    }
    task.resume()
}
}
