//
//  RowCell.swift
//  ExpandableTableView
//
//  Created by pradip gotamay on 2/22/17.
//  Copyright © 2017 Pradip Gotame. All rights reserved.
//

import UIKit

class RowCell: UITableViewCell {

    @IBOutlet weak var lbl_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
