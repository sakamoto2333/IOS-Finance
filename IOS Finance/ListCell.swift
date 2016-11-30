//
//  ListCell.swift
//  IOS Finance
//
//  Created by 123 on 16/11/1.
//  Copyright © 2016年 123. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var listclass: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
