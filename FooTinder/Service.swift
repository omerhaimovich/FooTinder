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
        return ["TLV",
                "Ramat Gan",
                "Givaatim",
                "Petach Tikva",
                "Ramat Hashron",
                "Hafula",
                "Hifa",
                "Nazenet"].sorted(by: {$0 < $1});
    }
    
    static func geFoodTypes() -> [String]
    {
        return ["Italian",
                "Chineese",
                "MidEstern",
                "Mexican",
                "Salads\\Sandwiches",
                "Caffe",
                "Sushi",
                "Humuns"].sorted(by: {$0 < $1});
    }
}
