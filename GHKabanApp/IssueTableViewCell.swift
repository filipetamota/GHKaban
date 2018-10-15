//
//  IssueTableViewCell.swift
//  GHKabanApp
//
//  Created by Filipe on 14/10/18.
//  Copyright © 2018 mota. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var moveRight: UIButton!
    @IBOutlet var moveLeft: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
