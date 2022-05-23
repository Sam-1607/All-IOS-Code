//
//  TeamNetworkController.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/9/22.
//

import Foundation

var leagueParam: String = ""
var seasonParam: String = ""
var teamParam: String = ""


class TeamNetworkController {
    func fetchTeam(completion: @escaping(Result<TeamStats, Error>) -> Void) {
        let urlRequest = NSMutableURLRequest(url: NSURL(string: "https://api-basketball.p.rapidapi.com/teams\(leagueParam)\(seasonParam)\(teamParam)")! as URL)
        urlRequest.allHTTPHeaderFields = [
            "X-RapidAPI-Host": "api-basketball.p.rapidapi.com",
            "X-RapidAPI-Key": "3e4fa7a698msha88ceb1d7d66dc8p154ec3jsn31c14c39616b"
        ]
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, response, error in
            let decoder = JSONDecoder()
            
            if let data = data {
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
}

class AllTeamsNetworkConroller {
    func fetchAllTeams(completion: @escaping(Result<[AllTeams], Error>) -> Void) {
        let urlRequest = NSMutableURLRequest(url: NSURL(string: "https://api-basketball.p.rapidapi.com/teams\(leagueParam)\(seasonParam)")! as URL)
        urlRequest.allHTTPHeaderFields = [
            "X-RapidAPI-Host": "api-basketball.p.rapidapi.com",
                "X-RapidAPI-Key": "3e4fa7a698msha88ceb1d7d66dc8p154ec3jsn31c14c39616b"
        ]
        
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { data, response, error in
            let decoder = JSONDecoder()
            if let data = data {
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
}


