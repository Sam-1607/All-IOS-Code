import UIKit
import Foundation
struct Representative: Codable {
    var party: String
    var name: String
    var link: String
    enum CodingKeys: String, CodingKey {
        case party
        case name
        case link
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        party = try values.decode(String.self, forKey: CodingKeys.party)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        link = try values.decode(String.self, forKey: CodingKeys.link)
    }
}

struct SearchResponse: Codable {
    let results: [Representative]
}


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

