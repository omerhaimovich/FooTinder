//
//  StudentTableViewCell.swift
//  TestFb
//
//  Created by Eliav Menachi on 04/01/2017.
//  Copyright © 2017 menachi. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var meal_image: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var restaurant: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
