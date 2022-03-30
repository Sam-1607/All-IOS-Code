//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Patch, Benjamin on 11/15/21.
//

import UIKit

class ViewController: UIViewController {

    var networkController = PhotoInfoController()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        networkController.fetchPhotoInfo { result in
            switch result {
            case .success(let photoInfo):
                DispatchQueue.main.async {
                    self.title = photoInfo.title
                    self.descriptionLabel.text = photoInfo.description
                    self.copyrightLabel.text = photoInfo.copyright
                    self.imageView.setImage(from: photoInfo.url)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

