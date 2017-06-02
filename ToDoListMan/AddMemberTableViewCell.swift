//
//  AddMemberTableViewCell.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 6. 2..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit

class AddMemberTableViewCell: UITableViewCell {

    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var check: UIButton!
    
    var tapAction: ((UITableViewCell) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnCheckclicked(_ sender: AnyObject) {
        tapAction?(self)
    }
}
