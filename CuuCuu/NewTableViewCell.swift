//
//  NewTableViewCell.swift
//  CuuCuu
//
//  Created by Jorge Enrique Chavez on 1/31/17.
//  Copyright © 2017 Simplewa. All rights reserved.
//

import UIKit

class NewTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!    
    
    @IBOutlet weak var title: UITextView!
    @IBOutlet weak var link: UILabel!
    
    @IBOutlet weak var category: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
