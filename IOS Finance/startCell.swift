//
//  startCell.swift
//  IOS Finance
//
//  Created by 123 on 16/11/8.
//  Copyright © 2016年 123. All rights reserved.
//

import UIKit

class startCell: UITableViewCell {

    @IBOutlet weak var startdate: UIDatePicker?
    @IBOutlet weak var enddate: UIDatePicker?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
