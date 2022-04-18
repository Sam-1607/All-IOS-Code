import Foundation

struct Country: Codable {
    var name: String
    var flag: String
}

struct Response: Codable {
    var response: [League]
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

func fetch(completion: @escaping(Result<League, Error>) -> Void) {
    let urlRequest = NSMutableURLRequest(url: NSURL(string: "https://api-basketball.p.rapidapi.com/leagues")! as URL)
    urlRequest.allHTTPHeaderFields = [
        "X-RapidAPI-Host": "api-basketball.p.rapidapi.com",
        "X-RapidAPI-Key": "3e4fa7a698msha88ceb1d7d66dc8p154ec3jsn31c14c39616b"
    ]
    let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, response, error in
        let decoder = JSONDecoder()
        
        if let data = data {
            do {
                let decodedLeauge = try decoder.decode(League.self, from: data)
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

fetch { response in
    print(response)
}






//func fetch() {
//    let urlComponents = URLComponents(string: "https://api-basketball.p.rapidapi.com/leagues")
//    let decoder = JSONDecoder()
//    let task = URLSession.shared.dataTask(with: (urlComponents?.url)!) { data, response, error in
//        if let response = response {
//            print(response)
//        }
//        if let data = data {
//            do {
//            let decodedLeagues = try decoder.decode(Response.self, from: data)
//                print(decodedLeagues)
//              //  self.leagues = decodedLeagues.results
//            }
//            catch {
//                print(error)
//            }
//        }
//    }
//    task.resume()
//}
//
//fetch()


//var urlRequest = NSMutableURLRequest(url: NSURL(string: "https://api-basketball.p.rapidapi.com/leagues")! as URL)
//urlRequest.allHTTPHeaderFields = [
//    "X-RapidAPI-Host": "api-basketball.p.rapidapi.com",
//        "X-RapidAPI-Key": "3e4fa7a698msha88ceb1d7d66dc8p154ec3jsn31c14c39616b"
//]
//let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, response, error in
//  if let data = data,
//    let string = String(data: data, encoding: .utf8) {
//      print(string)
//    }
//}
//task.resume()













