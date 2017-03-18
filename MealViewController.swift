//
//  MealViewController.swift
//  FooTinder
//
//  Created by Tom Acco on 3/18/17.
//  Copyright © 2017 Omer Haimovich. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {
    
    // View Labels
    @IBOutlet weak var lblMealName: UILabel!
    @IBOutlet weak var imgMealImage: UIImageView!
    @IBOutlet weak var ctrlRatingControl: RatingControl!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblRestaurant: UILabel!
    @IBOutlet weak var type: UILabel!
    var meal: Meal?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let meal = meal {
         
            // update view in database.
           let show_meal = Meal(id: meal.id, name: meal.name, imageUrl: meal.imageUrl, type: meal.type, location: meal.location, cost: meal.cost, views: meal.views + 1, restaurant: meal.restaurant, rating: meal.rating)
            
            Model.instance.addMeal(meal: show_meal);
            
            // set view properties
            self.lblMealName!.text = meal.name;
            self.ctrlRatingControl.rating = meal.rating;
            self.lblCost!.text = "$"  + String(meal.cost);
            self.lblRestaurant!.text = String(meal.restaurant);
            self.lblLocation!.text = meal.location;
            self.type.text = meal.type
            
            
            if let imUrl = meal.imageUrl{
                Model.instance.getImage(urlStr: imUrl, callback: { (image) in
                    self.imgMealImage!.image = image
                })
            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
