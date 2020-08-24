//
//  HeaderCell.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 23/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var lblTitle: IVLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.textColor = UIColor.themeTextGrayColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
