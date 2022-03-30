//
//  DogViewController.swift
//  API Project
//
//  Created by Sam Hiatt  on 11/19/21.
//

import Foundation
import UIKit
class DogViewController: UIViewController {
    var networkController = DogItemController()
    
    @IBOutlet weak var dogImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkController.fetchDogImage { result in
            switch result {
            case .success(let dogImageStuff):
                DispatchQueue.main.async {
                    self.dogImageView.setImage(from: dogImageStuff.message)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    @IBAction func dogButton(_ sender: Any) {
        networkController.fetchDogImage { result in
            switch result {
            case .success(let dogImageStuff):
                DispatchQueue.main.async {
                    self.dogImageView.setImage(from: dogImageStuff.message)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
