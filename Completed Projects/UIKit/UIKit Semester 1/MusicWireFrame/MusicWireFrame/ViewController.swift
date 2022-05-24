//
//  ViewController.swift
//  MusicWireFrame
//
//  Created by Sam Hiatt  on 11/9/21.
//

import UIKit

class ViewController: UIViewController {
    var isPlaying = true {
        didSet {
            playButton.isSelected = isPlaying
        }
    }
    
   
    @IBOutlet weak var albumView: UIView!
    @IBOutlet weak var reverseButton: UIButton!
    
   
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var reverseBackground: UIView!
    @IBOutlet weak var playBackground: UIView!
    @IBOutlet weak var forwardBackground: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Do any additional setup after loading the view.
//        reverseBackground.layer.cornerRadius = reverseBackground.frame.height / 2
//        reverseBackground.clipsToBounds = true
//        reverseBackground.alpha = 0
        
        [reverseBackground, playBackground, forwardBackground].forEach { view in
            guard let view = view else {return}
            view.layer.cornerRadius = view.frame.height / 2
            view.alpha = 0
        }
    }
    @IBAction func playButtonTapped(_ sender: Any) {
        isPlaying.toggle()
        if isPlaying {
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: [], animations: {
                self.albumView.transform = CGAffineTransform.identity
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5) {
                self.albumView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
    }
    
    @IBAction func touchedDown(_ sender: UIButton) {
        let buttonBackground: UIView
        
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case playButton:
            buttonBackground = playBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default: return
        }
        UIView.animate(withDuration: 0.25) {
            buttonBackground.alpha = 0.3
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    @IBAction func touchedUpInside(_ sender: UIButton) {
        let buttonBackground: UIView
        
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case playButton:
            buttonBackground = playBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default: return
        }
        UIView.animate(withDuration: 0.25) {
            buttonBackground.alpha = 0
            buttonBackground.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            sender.transform = CGAffineTransform.identity
        } completion: { _ in
            buttonBackground.transform = CGAffineTransform.identity
            
        }
    }
    

}

