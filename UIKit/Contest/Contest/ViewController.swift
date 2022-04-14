//
//  ViewController.swift
//  Contest
//
//  Created by Sam Hiatt  on 11/9/21.
//

import UIKit

class ViewController: UIViewController {

    //var translation = CGAffineTransform(translationX: 0.5, y: 0)
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func submitButton(_ sender: UIButton) {
        if emailTextField.text == "" {
            UIView.animate(withDuration: 5, delay: 0,usingSpringWithDamping: 0.1, initialSpringVelocity: 1000000, animations: {
                self.emailTextField.transform = CGAffineTransform(translationX: 5, y: 0)
                
            }) {(_) in
                self.emailTextField.transform = CGAffineTransform.identity
            }
        } else {
            performSegue(withIdentifier: "myShowSegue", sender: UIButton())        }

    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

