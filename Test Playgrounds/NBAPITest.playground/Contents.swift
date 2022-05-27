import Foundation




struct Country: Codable {
    var name: String
    var flag: String?
}

struct League: Codable {
    var country: Country
    var id: Int
    var type: String
    var name: String
}
struct Response: Codable {
    var response: [League]
}

func fetch(completion: @escaping(Result<[League], Error>) -> Void) {
    let urlRequest = NSMutableURLRequest(url: NSURL(string: "https://api-basketball.p.rapidapi.com/leagues")! as URL)
    urlRequest.allHTTPHeaderFields = [
        "X-RapidAPI-Host": "api-basketball.p.rapidapi.com",
        "X-RapidAPI-Key": "3e4fa7a698msha88ceb1d7d66dc8p154ec3jsn31c14c39616b"
    ]
    let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, response, error in
        let decoder = JSONDecoder()

        if let data = data {
            do {
                let decodedResponse = try decoder.decode(Response.self, from: data)
                completion(.success(decodedResponse.response))
                print(data)
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

//
//struct TeamResponse: Codable {
//    var response: [Team]
//}
//
//struct Country: Codable {
//    var flag: String
//    var name: String
//}
//
//struct Team: Codable {
//    var name: String
//    var nationnal: Bool
//    var logo: String
//    var country: Country
//}

//var teams: [Team] = []
//
//
//func fetch2(completion: @escaping(Result<[Team], Error>) -> Void) {
//    let urlRequest = NSMutableURLRequest(url: NSURL(string: "https://api-basketball.p.rapidapi.com/teams")! as URL)
//    urlRequest.allHTTPHeaderFields = [
//        "X-RapidAPI-Host": "api-basketball.p.rapidapi.com",
//            "X-RapidAPI-Key": "3e4fa7a698msha88ceb1d7d66dc8p154ec3jsn31c14c39616b"
//    ]
//    let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, response, error in
//        let decoder = JSONDecoder()
//
//        if let data = data {
//            print(data)
//            do {
//                let decodedResponse = try decoder.decode(TeamResponse.self, from: data)
//                completion(.success(decodedResponse.response))
//            }
//            catch {
//                completion(.failure(error))
//                print(error)
//            }
//        }
//    }
//    task.resume()
//}
//
//fetch2 { results in
//    switch results {
//    case .success(let team):
//        teams = team
//
//    case .failure(let error):
//        print(error.localizedDescription)
//    }
//}
//
