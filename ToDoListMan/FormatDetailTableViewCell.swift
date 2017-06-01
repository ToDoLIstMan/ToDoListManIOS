//
//  FormatDetailTableViewCell.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 6. 1..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit

class FormatDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var txtPlanName: UILabel!
    @IBOutlet weak var txtDetail: UILabel!
    @IBOutlet weak var txtTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
