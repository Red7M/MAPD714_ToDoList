//
//  ToDoItemTableViewCell.swift
//  RedaMehali_MAPD714_Assignment04
//
//  Created by Reda Mehali on 11/29/20.
//

import UIKit

class ToDoItemTableViewCell: UITableViewCell {
    
    //Mark: Properties
    @IBOutlet weak var toDoItemTitleText: UITextView!
    @IBOutlet weak var toDoItemDueText: UITextView!
    @IBOutlet weak var toDoItemSwitchState: UISwitch!
    @IBOutlet weak var toDoItemEditImageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
