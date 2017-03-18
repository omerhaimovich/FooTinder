//
//  MealViewController.swift
//  FooTinder
//
//  Created by Tom Acco on 3/18/17.
//  Copyright © 2017 Omer Haimovich. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {
    
    var meal: Meal?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let meal = meal {
         
           var show_meal = Meal(id: meal.id, name: meal.name, imageUrl: meal.imageUrl, type: meal.type, location: meal.location, cost: meal.cost, views: meal.views + 1, restaurant: meal.restaurant, rating: meal.rating)
            
            Model.instance.addMeal(meal: show_meal)
        }
        
        //Model.instance.addMeal(meal: show_meal)
        // Do any additional setup after loading the view.
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
