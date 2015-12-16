//
//  StepListCell.swift
//  GetWell
//
//  Created by Keron Williams on 12/16/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class StepListCell: UITableViewCell
{
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
