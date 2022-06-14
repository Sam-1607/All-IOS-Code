//
//  SettingsViewController.swift
//  NBA
//
//  Created by Sam Hiatt  on 6/13/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var volumeLabel: UILabel!
    
    @IBOutlet var volumeSliderOutlet: UISlider!
    
    @IBAction func volumeSlider(sender: UISlider) {
        
        let selectedValue = volumeSliderOutlet.value
        musicPlayer?.volume = selectedValue
        
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        
        volumeLabel.text = formatter.string(from: selectedValue as NSNumber)
    }
    
    let formatter = NumberFormatter()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
