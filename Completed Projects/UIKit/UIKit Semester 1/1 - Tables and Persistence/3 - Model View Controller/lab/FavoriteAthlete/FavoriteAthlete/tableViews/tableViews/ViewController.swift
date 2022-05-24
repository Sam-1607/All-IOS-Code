//
//  ViewController.swift
//  tableViews
//
//  Created by Sam Hiatt  on 10/11/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var dates = [Date]()
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        dates.append(Date())
        tableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dates.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell =  tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        let dates = dates[indexPath.row]
        cell.textLabel?.text = "\(dates)"
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

