//
//  Service.swift
//  FooTinder
//
//  Created by Tom Acco on 3/17/17.
//  Copyright © 2017 Omer Haimovich. All rights reserved.
//

import Foundation

class Service{
    static var location_filter = ""
    static var meal_name_filter = ""
    static var restaurant_filter = ""
    static var type_filter = ""
    static var max_cost_filter = 9999.0
    
    static func getLocations() -> [String]
    {
        return ["Tel Aviv",
                "Ramat Gan",
                "Givataim",
                "Petach Tikva",
                "Ramat Hashron",
                "Afula",
                "Haifa",
                "Nazenet"].sorted(by: {$0 < $1});
    }
    
    static func setFilters(location :String, meal_name :String, restaurant: String, type: String, max_cost :Double)
    {
        Service.location_filter = location
        Service.meal_name_filter = meal_name
        Service.restaurant_filter = restaurant
        Service.type_filter = type
        Service.max_cost_filter = max_cost
    }
    
    static func getLocationWithNone() -> [String]
    {
        var locations = Service.getLocations()
        locations.insert("None", at: 0)
        return locations
    }
    
    static func getFoodTypesWithNone() -> [String]
    {
        var types = Service.getFoodTypes()
        types.insert("None", at: 0)
        return types
    }
    
    static func getFoodTypes() -> [String]
    {
        return ["Italian",
                "Chinese",
                "MidEastern",
                "Mexican",
                "Salads\\Sandwiches",
                "Caffe",
                "Sushi",
                "Humus"].sorted(by: {$0 < $1});
    }
}
