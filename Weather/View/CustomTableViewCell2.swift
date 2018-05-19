//
//  CustomTableViewCell2.swift
//  Weather
//
//  Created by NguyenDinhPhu on 5/19/18.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit

class CustomTableViewCell2: UITableViewCell {

    @IBOutlet weak var cloudImage: UIImageView!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var speedCloud: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
