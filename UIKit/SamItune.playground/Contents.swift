import UIKit
import PlaygroundSupport
import Foundation
import Darwin
PlaygroundPage.current.needsIndefiniteExecution = true

let queryDictionary = ["term": "Kung Fu Panda", "media": "movie", "explicit": "No", "limit": "1000000"]

let itunesURL = URL(string: "https://itunes.apple.com/search")!
var components = URLComponents(url: itunesURL, resolvingAgainstBaseURL: false)
components?.queryItems = queryDictionary.map({ keyValue in
    URLQueryItem(name: keyValue.key, value: keyValue.value)
    
})
URLSession.shared.dataTask(with: components!.url!) { data, response, error in
    if let data = data, let dataString = String(data: data, encoding: .utf8) {
        print(dataString)
    }
}.resume()

extension Data {
    func prettyPrintedJSONString() {
        guard
            let jsonObject = try?
                JSONSerialization.jsonObject(with: self,
                                             options: []),
            let jsonData = try?
                JSONSerialization.data(withJSONObject:
                                        jsonObject, options: [.prettyPrinted]),
            let prettyJSONString = String(data: jsonData,
                                          encoding: .utf8) else {
                print("Failed to read JSON Object.")
                return
            }
        print(prettyJSONString)
    }
}
URLSession.shared.dataTask(with: components!.url!) { (data,
                                                      response, error) in
    if let data = data {
        data.prettyPrintedJSONString()
        PlaygroundPage.current.finishExecution()
    }
}.resume()

struct StoreItem: Codable {
    var artistName: String
    var trackName: String
    var kind: String
    var artWorkURL: String
    var longDescription: String?
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case kind
        case artWorkURL = "artworkUrl100"
        case description = "shortDescription"
    }
    enum AdditionalKeys: String, CodingKey {
        case longDescription
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trackName = try values.decode(String.self, forKey: CodingKeys.trackName)
        artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
        kind = try values.decode(String.self, forKey: CodingKeys.kind)
        artWorkURL = try values.decode(String.self, forKey: CodingKeys.artWorkURL)
        if let description = try? values.decode(String.self, forKey: CodingKeys.description) {
            self.description = description
        } else {
            let additionalValues = try decoder.container(keyedBy: AdditionalKeys.self)
            description = (try? additionalValues.decode(String.self, forKey: AdditionalKeys.longDescription)) ?? ""
        }
    }
    
    
}
struct SearchResponse: Codable {
    let results: [StoreItem]
}

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
let query = ["term": "Apple", "media": "ebook", "attribute": "authorTerm", "lang": "en_us", "limit": "10"]

fetchItems(matching: query) { (result) in
    switch result {
    case .success(let storeItems):
        storeItems.forEach { item in
            print("""
            Name: \(item.artistName)
            trackName: \(item.trackName)
            Kind: \(item.kind)
            Description: \(item.description)
            Artwork URL: \(item.artWorkURL)
             
            """)
        }
    case .failure(let error):
        print(error)
    }
    PlaygroundPage.current.finishExecution()
}




