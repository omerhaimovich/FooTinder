//
//  FilterPopOverViewController.swift
//  FooTinder
//
//  Created by Tom Acco on 3/17/17.
//  Copyright © 2017 Omer Haimovich. All rights reserved.
//

import UIKit

class FilterPopOverViewController: UIViewController,  UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var restaurantName: UITextField!
    
    @IBOutlet weak var maxCost: UITextField!
    @IBOutlet weak var meal_name: UITextField!
    
    @IBAction func restore(_ sender: Any) {
        Service.setFilters(location: "", meal_name: "", restaurant: "", type: "", max_cost: 9999.0)
        let table = storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        table.filter()
        self.dismiss(animated: false, completion: nil)
        
    }
    @IBOutlet weak var restaurant_name: UITextField!
    @IBAction func filter(_ sender: Any) {
        var max_cost = 9999.0
        if (maxCost.text != nil)
        {
            max_cost = Double(maxCost.text!)!
        }
        
        Service.setFilters(location: locationText.text!, meal_name: mealName.text!, restaurant: restaurantName.text!, type: TypeText.text!, max_cost: max_cost)
       let table = storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        
        table.filter()
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var mealName: UITextField!
    
    @IBOutlet weak var TypeText: UITextField!
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (pickerView.tag)
        {
            case (1):
                let value = Service.getLocationWithNone()[row]
                self.locationText.text = (value == "None" ? "" : value)
                break
            case (2):
                let value = Service.getFoodTypesWithNone()[row]
                TypeText.text = (value == "None" ? "" : value)
                break
            default:
                break;
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (pickerView.tag)
        {
        case (1):
            return Service.getLocationWithNone().count;
        case (2):
            return Service.getLocationWithNone().count;
        default:
            break;
        }
        return 0;
    }

    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (pickerView.tag)
        {
            case (1):
                return Service.getLocationWithNone()[row];
            case (2):
                return Service.getFoodTypesWithNone()[row];
            default:
                break;
        }
        
        return "Unknown"
    }

    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var locationPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationText.text = Service.location_filter
        mealName.text = Service.meal_name_filter
        TypeText.text = Service.type_filter
        restaurantName.text = Service.restaurant_filter
        if Service.max_cost_filter != 9999.0
        {
            maxCost.text = String(Service.max_cost_filter)
        }
        
        let locationPicker = UIPickerView()
        locationPicker.tag = 1
        locationPicker.delegate = self
        locationText.inputView = locationPicker
        
        let typepicker = UIPickerView()
        typepicker.tag = 2
        typepicker.delegate = self
        TypeText.inputView = typepicker
        

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
