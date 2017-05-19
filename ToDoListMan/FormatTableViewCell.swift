//
//  FormatTableViewCell.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 5. 19..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit

class FormatTableViewCell: UITableViewCell {

    @IBOutlet weak var txtFormatName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
