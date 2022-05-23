//
//  NetworkController.swift
//  NBA
//
//  Created by Sam Hiatt  on 4/13/22.
//

import Foundation
import UIKit

class LeagueNetworkController {
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
                
            }
            catch {
                completion(.failure(error))
                print(error)
            }
        }
    }
    task.resume()
}
    
    static func loadImage( from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else if let error = error {
                completion(.failure(error))
            } else {
                fatalError()
            }
        }.resume()
    }
}

extension UIImageView {
    func setImage(from url: URL) {
        LeagueNetworkController.loadImage(from: url) { result in
            guard case .success(let image) = result else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
}
