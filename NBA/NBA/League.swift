//
//  League.swift
//  NBA
//
//  Created by Sam Hiatt  on 4/12/22.
//

import Foundation

var leagueUrl = URL(string: "https://api-basketball.p.rapidapi.com/leagues")

struct Response: Codable {
    var results: [League]
}

struct League: Codable {
    var country: Country
    var id: Int
    var type: String
    var season: String
    var name: String
    var code: String
    var search: String
}

struct Country: Codable {
    var name: String
    var flag: String
}

func fetch(completion: @escaping(Result<Response, Error>) -> Void) {

let urlRequest = NSMutableURLRequest(url: NSURL(string: "https://api-basketball.p.rapidapi.com/leagues")! as URL)
urlRequest.allHTTPHeaderFields = [
    "X-RapidAPI-Host": "api-basketball.p.rapidapi.com",
        "X-RapidAPI-Key": "3e4fa7a698msha88ceb1d7d66dc8p154ec3jsn31c14c39616b"
]
let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, response, error in
    let decoder = JSONDecoder()

    if let data = data {
        do {
            let decodedLeauge = try decoder.decode(Response.self, from: data)
            completion(.success(decodedLeauge))
    }
        catch {
            completion(.failure(error))
            print(error)
        }
}
}
task.resume()

}
