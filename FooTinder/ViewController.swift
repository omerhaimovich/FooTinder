//
//  ViewController.swift
//  FooTinder
//
//  Created by Omer Haimovich on 17/03/2017.
//  Copyright © 2017 omertom. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var imageUrl:String?
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var restaurant: UITextField!
    @IBOutlet weak var idTf: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var location: UITextField!
    var selectedImage:UIImage?

    @IBOutlet weak var typeTextField: UITextField!
    
    @IBAction func selectPhotoFromLibrary(_ sender: UITapGestureRecognizer) {
        
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
        typeTextField.inputView = typepicker
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (pickerView.tag)
        {
        case (1):
            self.locationTextField.text = Service.getLocations()[row]
            break
        case (2):
            typeTextField.text = Service.geFoodTypes()[row]
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

    
    
    @IBAction func save(_ sender: UIButton) {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        if let image = self.selectedImage{
            Model.instance.saveImage(image: image, name:self.idTf!.text!){(url) in
            self.imageUrl = url
                            let meal = Meal(id: self.idTf.text!, name: self.nameTf.text!, imageUrl: self.imageUrl, type: self.type.text!, location: self.location.text!, cost: Double(self.cost.text!)!, comments: [], likes: 1, restaurant: self.restaurant.text!)
            Model.instance.addMeal(meal: meal)
            self.spinner.stopAnimating()
            self.navigationController!.popViewController(animated: true)
        }
        }else{
            let alertController = UIAlertController(title: "Missing Image", message:
                "Image must be selected!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

    @IBAction func cancel(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        selectedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.userAvatar.image = selectedImage
        
        self.dismiss(animated: true, completion: nil);
    }
    
    
    
    
}








