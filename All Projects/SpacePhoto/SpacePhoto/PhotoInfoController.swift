//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Patch, Benjamin on 11/15/21.
//

import Foundation
import UIKit

struct PhotoInfoController {
    
    func fetchPhotoInfo(completion: @escaping (Result<PhotoInfo,
       Error>) -> Void) {
        var urlComponents = URLComponents(string:
           "https://api.nasa.gov/planetary/apod")!
        urlComponents.queryItems = [
            "api_key": "DEMO_KEY",
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let task = URLSession.shared.dataTask(with:
           urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let photoInfo = try
                       jsonDecoder.decode(PhotoInfo.self, from: data)
                    completion(.success(photoInfo))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
    task.resume()
    }

    static func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
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
        PhotoInfoController.loadImage(from: url) { result in
            guard case .success(let image) = result else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
}
