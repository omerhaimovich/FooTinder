//
//  Service.swift
//  FooTinder
//
//  Created by Tom Acco on 3/17/17.
//  Copyright © 2017 Omer Haimovich. All rights reserved.
//

import Foundation

class Service{
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
    
    static func geFoodTypes() -> [String]
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
