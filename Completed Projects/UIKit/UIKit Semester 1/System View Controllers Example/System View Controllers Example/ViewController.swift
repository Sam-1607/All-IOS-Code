//
//  ViewController.swift
//  System View Controllers Example
//
//  Created by Sam Hiatt  on 10/27/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var outwardImage: UIImageView!
    
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let image = outwardImage.image else {return}
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true, completion: nil)
        }
    
    
    @IBAction func safariButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "https://www.specialized.com/us/en") {
           let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)

        }

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

