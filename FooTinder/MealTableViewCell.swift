//
//  StudentTableViewCell.swift
//  FooTinder
//
//  Created by Omer Haimovich on 16/3/2017.
//  Copyright © 2017 Omer Haimovich. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var meal_image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var restaurant: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
