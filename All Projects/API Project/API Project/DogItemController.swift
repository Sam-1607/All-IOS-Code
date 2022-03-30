//
//  DogItemController.swift
//  API Project
//
//  Created by Sam Hiatt  on 11/19/21.
//

import Foundation
import UIKit
class DogItemController {
    func fetchDogImage(completion: @escaping (Result<Dog, Error>) -> Void) {
        let urlComponent = URLComponents(string: "https://dog.ceo/api/breeds/image/random")!
        let task = URLSession.shared.dataTask(with: urlComponent.url!) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedImage = try decoder.decode(Dog.self, from: data)
                    completion(.success(decodedImage))
                    
                } catch {
                    completion(.failure(error))
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
        DogItemController.loadImage(from: url) { result in
            guard case .success(let image) = result else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
}
