import Foundation
import PlaygroundSupport

var greeting = "Hello, playground"


struct AllTeams: Codable {
    var id: Int
    var name: String
    var logo: String
}

struct AllTeamsResponse: Codable {
    var response: [AllTeams]
}


struct NOData: Error {
    
}

func fetch2(completion: @escaping(Result<[AllTeams], Error>) -> Void) {
    let urlRequest = NSMutableURLRequest(url: NSURL(string: "https://api-basketball.p.rapidapi.com/teams?league=12")! as URL)
    urlRequest.allHTTPHeaderFields = [
        "X-RapidAPI-Host": "api-basketball.p.rapidapi.com",
            "X-RapidAPI-Key": "3e4fa7a698msha88ceb1d7d66dc8p154ec3jsn31c14c39616b"

    ]
    let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, response, error in
        let decoder = JSONDecoder()
        
        if let data = data {
            print(String(data: data, encoding: .utf8))
            do {
                let decodedResponse = try decoder.decode(AllTeamsResponse.self, from: data)
                completion(.success(decodedResponse.response))
            }
            catch {
                completion(.failure(error))
                print(error)
            }
        } else {
            completion(.failure(NOData()))
        }
    }
    task.resume()
}
PlaygroundPage.current.needsIndefiniteExecution = true

fetch2 { result in
    switch result {
    case .success(let allTeams):
        print("received Data \(allTeams)")
    case .failure(let error):
        print(error.localizedDescription)
    }
}
