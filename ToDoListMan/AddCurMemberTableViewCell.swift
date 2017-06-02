//
//  AddCurMemberTableViewCell.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 6. 2..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit

class AddCurMemberTableViewCell: UITableViewCell {

    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    
    var tapAction: ((UITableViewCell) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnCheckClicked(_ sender: Any) {
        tapAction?(self)
    }
}
