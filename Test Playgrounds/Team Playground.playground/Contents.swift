import UIKit
import PlaygroundSupport

struct TotalFor: Codable {
    var home: Int
    var away: Int
    var all: Int
}

struct AverageFor: Codable {
    var home: String
    var away: String
    var all: String
}

struct TotalAgainst: Codable {
    var home: Int
    var away: Int
    var all: Int
}

struct AverageAgainst: Codable {
    var home: String
    var away: String
    var all: String
}

struct For: Codable {
    var total: TotalFor
    var average: AverageFor
}

struct Against: Codable {
    var total: TotalAgainst
    var average: AverageAgainst
}

struct HomeWins: Codable {
    var total: Int
    var percentage: String
}

struct AwayWins: Codable {
    var total: Int
    var percentage: String
}

struct AllWins: Codable {
    var total: Int
    var percentage: String
}

struct HomeDraws: Codable {
    var total: Int
    var percentage: String
}

struct AwayDraws: Codable {
    var total: Int
    var percentage: String
}

struct AllDraws: Codable {
    var total: Int
    var percentage: String
}

struct HomeLosses: Codable {
    var total: Int
    var percentage: String
}

struct AwayLosses: Codable {
    var total: Int
    var percentage: String
}

struct AllLosses: Codable {
    var total: Int
    var percentage: String
}

struct Draws: Codable {
    var home: HomeDraws
    var away: AwayDraws
    var all: AllDraws
}

struct Points: Codable {
    var forPoints: For
    var against: Against
    
    enum CodingKeys: String, CodingKey {
        case forPoints = "for"
        case against
    }
}

struct AllGamesPlayed: Codable {
    var home: Int
    var away: Int
    var all: Int
}


struct Wins: Codable {
    var home: HomeWins
    var away: AwayWins
    var all: AllWins
}

struct Losses: Codable {
    var home: HomeLosses
    var away: AwayLosses
    var all: AllLosses
}

struct Game: Codable {
    var played: AllGamesPlayed
    var wins: Wins
    var draws: Draws
    var loses: Losses
}

struct TeamCountry: Codable {
    var id: Int?
    var flag: String?
    var name: String?
}

struct Team: Codable {
    var id: Int
    var name: String
}

struct TeamLeague: Codable {
    var id: Int
    var name: String
    var season: String
    var logo: String
}

struct TeamStats: Codable {
    var country: TeamCountry
    var league: TeamLeague
    var team: Team
    var games: Game
    var points: Points
    
}

struct TeamResponse: Codable {
    var response: TeamStats
}

struct NOData: Error {
    
}

var testURL = "https://api-basketball.p.rapidapi.com/statistics?league=13&season=2014&team=96"

func fetch2(completion: @escaping(Result<TeamStats, Error>) -> Void, myURL: String) {
    let urlRequest = NSMutableURLRequest(url: NSURL(string: myURL)! as URL)
    urlRequest.allHTTPHeaderFields = [
        "X-RapidAPI-Host": "api-basketball.p.rapidapi.com",
            "X-RapidAPI-Key": "3e4fa7a698msha88ceb1d7d66dc8p154ec3jsn31c14c39616b"
    ]
    let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, response, error in
        let decoder = JSONDecoder()
        
        if let data = data {
            print(String(data: data, encoding: .utf8))
            do {
                let decodedResponse = try decoder.decode(TeamResponse.self, from: data)
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

fetch2(completion: { result in
    switch result {
    case .success(let teamStats):
        print("received data: \(teamStats)")
    case .failure(let error):
        print(error.localizedDescription)
    }
}, myURL: testURL)
