//
//  TableViewController.swift
//  TestFb
//
//  Created by Eliav Menachi on 28/12/2016.
//  Copyright © 2016 menachi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    var mealList = [Meal]()
    
    @IBAction func showFilter(_ sender: UIBarButtonItem) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "FilterPopOverController") as! FilterPopOverViewController
        VC.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height:  500)
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
        self.tableView!.reloadData()
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
        cell.cost!.text = String(self.mealList[indexPath.row].cost) + "$"
        cell.likes!.text = String(self.mealList[indexPath.row].likes) + " likes"
        cell.type!.text = self.mealList[indexPath.row].type
        cell.location!.text = self.mealList[indexPath.row].location
        if let imUrl = self.mealList[indexPath.row].imageUrl{
            Model.instance.getImage(urlStr: imUrl, callback: { (image) in
                cell.meal_image!.image = image
            })
        }
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
