//
//  FoodTableTableViewController.swift
//  Meal Tracker
//
//  Created by Sam Hiatt  on 10/11/21.
//

import UIKit

class FoodTableTableViewController: UITableViewController {
    
    var meals: [Meal] {
        var breakfast = Meal(name: "breakfast", food: [Food(name: "Waffle", description: "Very Filling for some reason"), Food(name: "Egg", description: "I usally eat 6 of these at a time"), Food(name: "Bacon", description: "never gets old")])
        
        
        
        var lunch = Meal(name: "lunch", food: [Food(name: "Nachos", description: "Pretty Good especially from Los Hermanos"), Food(name: "Ramen", description: "Classic"), Food(name: "Cereal", description: "Never gets old")])
        
        
        var dinner = Meal(name: "dinner", food: [ Food(name: "Spaghetti", description: "Literally the my favorite meal ever"), Food(name: "Stir Fry", description: "Great for for Football Season always bulks me up"), Food(name: "Pizza ", description: "unhealthy but tastes awsome")])
       
        return [breakfast, lunch, dinner]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return meals.count
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let meal = meals[section]
        
        
        return meal.food.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food", for: indexPath)
        let meal = meals[indexPath.section]
        let food = meal.food[indexPath.row]
        cell.textLabel?.text = food.name
        cell.detailTextLabel?.text = food.description
        
    
        
        

        // Configure the cell...
        

        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let someMeal = meals[section]
        let foodName = someMeal.name
        
        return foodName
    }
    
    
}
