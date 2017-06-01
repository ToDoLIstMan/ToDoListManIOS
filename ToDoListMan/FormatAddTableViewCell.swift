//
//  FormatAddTableViewCell.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 6. 1..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit

class FormatAddTableViewCell: UITableViewCell {

    @IBOutlet weak var txtPlanName: UILabel!
    @IBOutlet weak var txtPlanDetail: UILabel!
    @IBOutlet weak var txtPlanTime: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
