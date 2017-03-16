//
//  Model.swift
//  TestFb
//
//  Created by Eliav Menachi on 14/12/2016.
//  Copyright © 2016 menachi. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage


class ModelFirebase{

    init(){
        FIRApp.configure()
    }
    
    func addMeal(meal:Meal, completionBlock:@escaping (Error?)->Void){
        let ref = FIRDatabase.database().reference().child("MEALS").child(meal.id)
        ref.setValue(meal.toFirebase())
        ref.setValue(meal.toFirebase()){(error, dbref) in
            completionBlock(error)
        }
    }
    
    func getMealById(id:String, callback:@escaping (Meal)->Void){
        let ref = FIRDatabase.database().reference().child("MEALS").child(id)
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            let json = snapshot.value as? Dictionary<String,String>
            let meal = Meal(json: json!)
            callback(meal)
        })
    }
    
    func getAllMeals(_ lastUpdateDate:Date? , callback:@escaping ([Meal])->Void){
        let handler = {(snapshot:FIRDataSnapshot) in
            var meals = [Meal]()
            for child in snapshot.children.allObjects{
                if let childData = child as? FIRDataSnapshot{
                    if let json = childData.value as? Dictionary<String,Any>{
                        let meal = Meal(json: json)
                        meals.append(meal)
                    }
                }
            }
            callback(meals)
        }
        
        let ref = FIRDatabase.database().reference().child("MEALS")
        if (lastUpdateDate != nil){
            print("q starting at:\(lastUpdateDate!) \(lastUpdateDate!.toFirebase())")
            let fbQuery = ref.queryOrdered(byChild:"lastUpdate").queryStarting(atValue:lastUpdateDate!.toFirebase())
            fbQuery.observeSingleEvent(of: .value, with: handler)
        }else{
            ref.observeSingleEvent(of: .value, with: handler)
        }
    }

    func getAllMealsAndObserve(_ lastUpdateDate:Date?, callback:@escaping ([Meal])->Void){
        let handler = {(snapshot:FIRDataSnapshot) in
            var meals = [Meal]()
            for child in snapshot.children.allObjects{
                if let childData = child as? FIRDataSnapshot{
                    if let json = childData.value as? Dictionary<String,Any>{
                        let meal = Meal(json: json)
                        meals.append(meal)
                    }
                }
            }
            callback(meals)
        }
        
        let ref = FIRDatabase.database().reference().child("MEALS")
        if (lastUpdateDate != nil){
            print("q starting at:\(lastUpdateDate!) \(lastUpdateDate!.toFirebase())")
            let fbQuery = ref.queryOrdered(byChild:"lastUpdate").queryStarting(atValue:lastUpdateDate!.toFirebase())
            fbQuery.observe(FIRDataEventType.value, with: handler)
        }else{
            ref.observe(FIRDataEventType.value, with: handler)
        }
    }
    
    lazy var storageRef = FIRStorage.storage().reference()
    
    func saveImageToFirebase(image:UIImage, name:(String), callback:@escaping (String?)->Void){
        let filesRef = storageRef.child(name)
        if let data = UIImageJPEGRepresentation(image, 0.8) {
            filesRef.put(data, metadata: nil) { metadata, error in
                if (error != nil) {
                    callback(nil)
                } else {
                    let downloadURL = metadata!.downloadURL()
                    callback(downloadURL?.absoluteString)
                }
            }
        }
    }
    
    func getImageFromFirebase(url:String, callback:@escaping (UIImage?)->Void){
        let ref = FIRStorage.storage().reference(forURL: url)
        ref.data(withMaxSize: 10000000, completion: {(data, error) in
            if (error == nil && data != nil){
                let image = UIImage(data: data!)
                callback(image)
            }else{
                callback(nil)
            }
        })
    }
    
 }
