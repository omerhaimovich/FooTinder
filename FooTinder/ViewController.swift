//
//  ViewController.swift
//  TestFb
//
//  Created by Eliav Menachi on 14/12/2016.
//  Copyright © 2016 menachi. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var imageUrl:String?
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var type: UITextField!
    
    @IBAction func editImage(_ sender: UIButton) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.isHidden = true
        
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

    
    @IBOutlet weak var nameTf: UITextField!
    
    @IBOutlet weak var restaurant: UITextField!
    @IBOutlet weak var idTf: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var location: UITextField!
    
    @IBAction func save(_ sender: UIButton) {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        if let image = self.selectedImage{
            Model.instance.saveImage(image: image, name:self.idTf!.text!){(url) in
            self.imageUrl = url
            //let st = Student(id: self.idTf!.text!, name: self.nameTf!.text!, imageUrl:self.imageUrl)
                let meal = Meal(id: self.idTf.text!, name: self.nameTf.text!, imageUrl: self.imageUrl, type: self.type.text!, location: self.location.text!, cost: Double(self.cost.text!)!, comments: [], likes: 1, restaurant: self.restaurant.text!)
            //Model.instance.addStudent(st: st)
            Model.instance.addMeal(meal: meal)
            self.spinner.stopAnimating()
            self.navigationController!.popViewController(animated: true)
        }
        }else{
            //let st = Student(id: self.idTf!.text!, name: self.nameTf!.text!)
            //Model.instance.addStudent(st: st)
            let meal = Meal(id: self.idTf.text!, name: self.nameTf.text!, type: self.type.text!, location: self.location.text!, cost: Double(self.cost.text!)!, comments: [], likes: 1, restaurant: self.restaurant.text!)
            Model.instance.addMeal(meal: meal)
            self.spinner.stopAnimating()
            self.navigationController!.popViewController(animated: true)
        }
    }

    @IBAction func cancel(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    var selectedImage:UIImage?
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        //let image = info["UIImagePickerControllerEditedImage"] as? UIImage
        selectedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.userAvatar.image = selectedImage
        
        self.dismiss(animated: true, completion: nil);
    }
}








