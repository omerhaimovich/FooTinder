//
//  ViewController.swift
//  FooTinder
//
//  Created by Omer Haimovich on 3/17/2017.
//  Copyright © 2017 Omer Haimovich. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var imageUrl:String?
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var restaurant: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var CostTF: UITextField!
    
    @IBOutlet weak var RatingControl: RatingControl!
    @IBOutlet weak var userAvatar: UIImageView!
    var selectedImage:UIImage?
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.isHidden = true;
        let locationPicker = UIPickerView()
        locationPicker.tag = 1
        locationPicker.delegate = self
        locationTextField.inputView = locationPicker
        
        let typepicker = UIPickerView()
        typepicker.tag = 2
        typepicker.delegate = self
        typeTextField.inputView = typepicker;
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self,action: "dismissKeyboard");
        
        view.addGestureRecognizer(tap);
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true);
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (pickerView.tag)
        {
        case (1):
            return Service.getLocations().count;
        case (2):
            return Service.getFoodTypes().count;
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
            return Service.getFoodTypes()[row];
        default:
            break;
        }
        
        return "Unknown"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (pickerView.tag)
        {
        case (1):
            self.locationTextField.text = Service.getLocations()[row]
            break
        case (2):
            typeTextField.text = Service.getFoodTypes()[row]
            break
        default:
            break;
        }
    }
    
    
    @objc func mealListDidUpdate(notification:NSNotification){
        let meals = notification.userInfo?["MEALS"] as! [Meal]
        for meal in meals {
            print("name: \(meal.name) \(meal.lastUpdate!)")
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    @IBAction func choosePhoto(_ sender: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }

    }

    @IBAction func save(_ sender: UIButton) {
        self.spinner.isHidden = false;
        self.spinner.startAnimating();
        
        if (self.nameTf!.text != nil && self.nameTf!.text != "")
        {
            if (self.restaurant!.text != nil && self.restaurant!.text != "")
            {
                if (self.typeTextField!.text != nil && self.typeTextField!.text != "")
                {
                    if (self.locationTextField!.text != nil && self.locationTextField!.text != "")
                    {
                        if (self.CostTF!.text != nil && self.CostTF!.text != "")
                        {
                            if let image = self.selectedImage{
                                
                                let id = self.nameTf!.text! + String(arc4random_uniform(10000000) + 1);
                                
                                //let id = self.nameTf!.text! + String(Date().toFirebase());
                                
                                
                                Model.instance.saveImage(image: image, name:id){(url) in
                                    self.imageUrl = url
                                    let meal = Meal(id: id, name: self.nameTf.text!, imageUrl: self.imageUrl, type: self.typeTextField.text!, location: self.locationTextField.text!, cost: Double(self.CostTF.text!)!, views: 1, restaurant: self.restaurant.text!, rating: self.RatingControl.rating)
                                    Model.instance.addMeal(meal: meal)
                                    self.spinner.stopAnimating()
                                    self.navigationController!.popViewController(animated: true)
                                }
                            }else{
                                alert(message: "Image must be selected!",header: "Missing Image");
                            }
                            
                            
                            
                        }
                        else
                        {
                             alert(message: "Cost must be selected!",header: "Missing Cost");
                        }
                    }
                    else
                    {
                         alert(message: "Location must be selected!",header: "Missing Location");
                    }
                }
                else
                {
                     alert(message: "Type must be selected!",header: "Missing Type");
                }
            }
            else
            {
                 alert(message: "Restaurant must be Filled!",header: "Missing Restaurant");
            }
        }
        else
        {
             alert(message: "Name must be filled!",header: "Missing Name");
        }
        
    }

    @IBAction func cancel(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    func alert(message: String, header: String)
    {
        let alertController = UIAlertController(title: header, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)

        self.spinner.stopAnimating()
        self.spinner.isHidden = true;

        
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        selectedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.userAvatar.image = selectedImage
        
        self.dismiss(animated: true, completion: nil);
    }
    
    
    
    
}








