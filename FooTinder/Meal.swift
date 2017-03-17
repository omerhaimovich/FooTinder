//
//  Meal.swift
//  FooTinder
//
//  Created by Tom Acco on 2/28/17.
//  Copyright © 2017 Tom Acco. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Meal{
    var id:String
    var name:String
    var imageUrl:String?
    var type:String
    var location:String
    var cost:Double
    var views:Double = 0
    var restaurant:String
    var rating:Int
    var lastUpdate:Date?
    
    init(id:String, name:String, imageUrl:String? = nil, type:String, location:String, cost:Double,  views:Double = 0, restaurant:String, rating: Int){
        self.id = id
        self.name = name
        self.restaurant = restaurant
        self.imageUrl = imageUrl
        self.type = type
        self.cost = cost
        self.location = location
        self.views = views
        self.rating = rating
    }
    
    init(json:Dictionary<String,Any>){
        self.id = json["id"] as! String
        self.name = json["name"] as! String
        self.type = json["type"] as! String
        self.restaurant = json["restaurant"] as! String
        self.cost = json["cost"] as! Double
        self.location = json["location"] as! String
        self.rating = json["rating"] as! Int
        self.views = json["views"] as! Double
        if let im = json["imageUrl"] as? String{
            imageUrl = im
        }
        if let ts = json["lastUpdate"] as? Double{
            self.lastUpdate = Date.fromFirebase(ts)
        }
    }
    
    func toFirebase() -> Dictionary<String,Any> {
        var json = Dictionary<String,Any>()
        json["id"] = id
        json["name"] = name
        json["type"] = type
        json["restaurant"] = restaurant
        json["cost"] = cost
        json["location"] = location
        json["views"] = views
        json["rating"] = rating
        if (imageUrl != nil){
            json["imageUrl"] = imageUrl!
        }
        json["lastUpdate"] = FIRServerValue.timestamp()
        return json
    }
}
