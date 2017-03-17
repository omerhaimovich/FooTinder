//
//  FilterPopOverViewController.swift
//  FooTinder
//
//  Created by Tom Acco on 3/17/17.
//  Copyright © 2017 Omer Haimovich. All rights reserved.
//

import UIKit

class FilterPopOverViewController: UIViewController,  UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var TypeText: UITextField!
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (pickerView.tag)
        {
            case (1):
                self.locationText.text = Service.getLocations()[row]
                break
            case (2):
                TypeText.text = Service.geFoodTypes()[row]
                break
            default:
                break;
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (pickerView.tag)
        {
        case (1):
            return Service.getLocations().count;
        case (2):
            return Service.geFoodTypes().count;
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
                return Service.getLocations()[row];
            case (2):
                return Service.geFoodTypes()[row];
            default:
                break;
        }
        
        return "Unknown"
    }

    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var locationPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
