//
//  TodoCell.swift
//  GetWell
//
//  Created by Keron Williams on 12/17/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var checkbox: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
