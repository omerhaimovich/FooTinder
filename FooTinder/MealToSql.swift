//
//  MealToSql.swift
//  FooTinder
//
//  Created by Tom Acco on 2/28/17.
//  Copyright © 2017 Tom Acco. All rights reserved.
//

import Foundation

extension Meal{
    static let ML_TABLE = "MEAL"
    
    static let ML_ID = "ST_ID"
    static let ML_NAME = "NAME"
    static let ML_IMAGE_URL = "IMAGE_URL"
    static let ML_TYPE = "TYPE"
    static let ML_LOCATION = "LOCATION"
    static let ML_VIEWS = "VIEWS"
    static let ML_RATING = "RATING"
    static let ML_COST = "COST"
    static let ML_RESTAURANT = "RESTAURANT"
    
    static let ML_LAST_UPDATE = "ST_LAST_UPDATE"
    
    
    static func createTable(database:OpaquePointer?)->Bool{
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        
        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS " + ML_TABLE + " ( " + ML_ID + " TEXT PRIMARY KEY, "
            + ML_NAME + " TEXT, "
            + ML_IMAGE_URL + " TEXT, "
            + ML_TYPE + " TEXT, "
            + ML_RESTAURANT + " TEXT, "
            + ML_LOCATION + " TEXT, "
            + ML_VIEWS + " DOUBLE, "
            + ML_COST + " DOUBLE, "
            + ML_RATING + " INT, "
            + ML_LAST_UPDATE + " DOUBLE)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return false
        }
        
        return true
    }
    
    func addMealToLocalDb(database:OpaquePointer?){
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO " + Meal.ML_TABLE
            + "(" + Meal.ML_ID + ","
            + Meal.ML_NAME + ","
            + Meal.ML_IMAGE_URL + ","
            + Meal.ML_TYPE + ","
            + Meal.ML_RESTAURANT + ","
            + Meal.ML_LOCATION + ","
            + Meal.ML_VIEWS + ","
            + Meal.ML_COST + ","
            + Meal.ML_RATING + ","
            + Meal.ML_LAST_UPDATE + ") VALUES (?,?,?,?,?,?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            
            let id = self.id.cString(using: .utf8)
            let name = self.name.cString(using: .utf8)
            let type = self.type.cString(using: .utf8)
            let restaurant = self.restaurant.cString(using: .utf8)
            let location = self.location.cString(using: .utf8)
            let rating = self.rating
            let views = self.views
            let cost = self.cost
            var imageUrl = "".cString(using: .utf8)
            if self.imageUrl != nil {
                imageUrl = self.imageUrl!.cString(using: .utf8)
            }
            var lastUpdate = self.lastUpdate
            
            sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, name,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, imageUrl,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, type,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, restaurant,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, location,-1,nil);
            sqlite3_bind_double(sqlite3_stmt, 7, views);
            sqlite3_bind_double(sqlite3_stmt, 8, cost);
            sqlite3_bind_int(sqlite3_stmt, 9, Int32(rating));
            if (lastUpdate == nil){
                lastUpdate = Date()
            }
            sqlite3_bind_double(sqlite3_stmt, 10, lastUpdate!.toFirebase());
            
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }
    
    static func getAllMealsFromLocalDb(database:OpaquePointer?)->[Meal]{
        var meals = [Meal]()
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"SELECT * from " + ML_TABLE + ";",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let stId =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,0))
                let name =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,1))
                var imageUrl =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,2))
                let type = String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,3))
                let restaurant = String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,4))
                let location = String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,5))
                let views = Double(sqlite3_column_double(sqlite3_stmt,6))
                let cost = Double(sqlite3_column_double(sqlite3_stmt,7))
                let rating = Int(sqlite3_column_int(sqlite3_stmt,8))
                let update =  Double(sqlite3_column_double(sqlite3_stmt,9))
                print("read from filter st: \(stId) \(name) \(imageUrl)")
                if (imageUrl != nil && imageUrl == ""){
                    imageUrl = nil
                }
                let meal = Meal(id: stId!,name: name!,imageUrl: imageUrl, type: type!, location: location!, cost: cost, views: views, restaurant: restaurant!, rating: Int(rating))
                meal.lastUpdate = Date.fromFirebase(update)
                meals.append(meal)
                
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return meals
    }
    
}
