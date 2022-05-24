//
//  ViewController.swift
//  AppEventCounter
//
//  Created by Sam Hiatt  on 10/5/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var didFinishLaunchingLabel: UILabel!
    
    @IBOutlet weak var configurationForConnectingLabel: UILabel!
    
    @IBOutlet weak var willConnectToLabel: UILabel!
    
    @IBOutlet weak var sceneDidBecomeActiveLabel: UILabel!
    
    @IBOutlet weak var sceneWillResignActiveLabel: UILabel!
    
    @IBOutlet weak var sceneWillEnterForeGroundLabel: UILabel!
    
    @IBOutlet weak var sceneDidEnterBackgroundLabel: UILabel!
    
    
    
    
    
    var willConnectToCount = 0
    var sceneDidBecomeActiveCount = 0
    var sceneWillResignActiveCount = 0
    var sceneWillEnterForeGroundCount = 0
    var sceneDidEnterBackground = 0
    var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    func updateView() {
        didFinishLaunchingLabel.text = "The App has Launched \(appDelegate.launchCount)"
        configurationForConnectingLabel.text = "The App has Configured Connection \(appDelegate.configurationForConnectingCount) times(s)"
        willConnectToLabel.text = "The App has run willConnectTo \(willConnectToCount) time(s)"
        sceneDidBecomeActiveLabel.text = "The App scene has Become active \(sceneDidBecomeActiveCount) time(s)"
        sceneWillResignActiveLabel.text = "The App scene has Resigned Active \(sceneWillResignActiveCount) time(s)"
        sceneWillEnterForeGroundLabel.text = "The Scene has entered the ForeGround \(sceneWillEnterForeGroundCount) times(s)"
        sceneDidEnterBackgroundLabel.text = "The Scene has finally entered the background \(sceneDidEnterBackground) time(s)"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

