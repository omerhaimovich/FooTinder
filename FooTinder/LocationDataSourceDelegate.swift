//
//  LocationDataSourceDelegate.swift
//  FooTinder
//
//  Created by Omer Haimovich on 3/17/2017.
//  Copyright © 2017 Omer Haimovich. All rights reserved.
//

import Foundation
import UIKit

class LocationDataSourceDelegate : NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }

    var pickerDataSource = ["Up", "Down", "Everywhere"]
    var selectedLocation : String?
    
    override init() {
        self.pickerDataSource = Service.getLocations();
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    private func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLocation = pickerDataSource[row]
    }
    
    
}
