//
//  TableViewCell.swift
//  ChecklistTest
//
//  Created by Michael Reynolds on 12/16/15.
//  Copyright © 2015 Michael Reynolds. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell
{
    @IBOutlet weak var toDoText: UITextField!

    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }

}
