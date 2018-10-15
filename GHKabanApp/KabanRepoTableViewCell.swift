//
//  KabanRepoTableViewCell.swift
//  TabAppTest
//
//  Created by Filipe on 14/10/18.
//  Copyright © 2018 mota. All rights reserved.
//

import UIKit

class KabanRepoTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ownerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
