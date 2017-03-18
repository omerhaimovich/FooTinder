//
//  TableViewController.swift
//  FooTinder
//
//  Created by Tom Acco on 3/17/2017.
//  Copyright © 2017 Tom Acco. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    var mealList = [Meal]()
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBAction func showFilter(_ sender: UIBarButtonItem) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "FilterPopOverController") as! FilterPopOverViewController
        VC.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height:  300)
        let navagetion = UINavigationController(rootViewController: VC)
        navagetion.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = navagetion.popoverPresentationController
        popover?.delegate = self
        popover?.barButtonItem = sender
        self.present(navagetion, animated: true, completion: nil)
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(ViewController.mealListDidUpdate),
                                               name: NSNotification.Name(rawValue: notifyMealListUpdate),object: nil)
        Model.instance.getAllMealsAndObserve()
    }
    
    @objc func mealListDidUpdate(notification:NSNotification){
        self.mealList = notification.userInfo?["MEALS"] as! [Meal]
        filter()
        self.sort()
        self.tableView!.reloadData()
    }
    
    func filter(){
        self.mealList = self.mealList.filter{
            (Service.meal_name_filter.isEmpty || ($0.name.lowercased().contains(Service.meal_name_filter.lowercased()))) &&
            (Service.restaurant_filter.isEmpty || ($0.restaurant.lowercased().contains(Service.restaurant_filter.lowercased()))) &&
            (Service.type_filter.isEmpty || ($0.type.lowercased().contains(Service.type_filter.lowercased()))) &&
            ($0.cost <= Service.max_cost_filter) &&
            (Service.location_filter.isEmpty || ($0.location.lowercased().contains(Service.location_filter.lowercased())))
        }
        
        self.sort()
        self.tableView!.reloadData()
    }
    
    func sort()
    {
        self.mealList = self.mealList.sorted(by: { (($0.lastUpdate! == $1.lastUpdate!) ? ($0.views > $1.views) : ($0.lastUpdate! > $1.lastUpdate!)) });
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mealList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell
        cell.name!.text = self.mealList[indexPath.row].name
        cell.restaurant!.text = self.mealList[indexPath.row].restaurant
        cell.cost!.text = "$" + String(self.mealList[indexPath.row].cost)
        cell.likes!.text = String(Int32(self.mealList[indexPath.row].views)) + " views"
        cell.location!.text = self.mealList[indexPath.row].location
        cell.ratingControl!.rating = self.mealList[indexPath.row].rating;
        if let imUrl = self.mealList[indexPath.row].imageUrl{
            Model.instance.getImage(urlStr: imUrl, callback: { (image) in
                cell.meal_image!.image = image
            })
        }
        return cell
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "mealDetails")
        {
        guard let mealDetailViewController = segue.destination as? MealViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedMealCell = sender as? MealTableViewCell else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedMeal = mealList[indexPath.row]
        mealDetailViewController.meal = selectedMeal
        }
     }
 
    
}
