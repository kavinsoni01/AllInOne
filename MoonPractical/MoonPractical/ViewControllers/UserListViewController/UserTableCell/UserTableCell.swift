//
//  UserTableCell.swift
//  MoonPractical
//
//  Created by Kavin Soni on 21/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit
import SDWebImage

class UserTableCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.async {
            self.imgUser.layer.cornerRadius = self.imgUser.frame.size.height/2
            self.imgUser.clipsToBounds = true 
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }
    
    
    func setData(obj:UserModel) -> Void {
        self.lblName.text = obj.full_name
        self.lblEmail.text = obj.email
        print( obj.profilePicUrl)
        self.imgUser.sd_setImage(with: URL(string: obj.profilePicUrl), placeholderImage: UIImage(named: "placeholder"))
        
//        let dateFormate = "dd,MMM,yyyy hh:mm:ss a"

        let dateFormate = "yyyy-MM-dd HH:mm:ss"//
                          let dateFormatter = DateFormatter()
                          dateFormatter.dateFormat = dateFormate
        if  let date = dateFormatter.date(from: obj.created_at) {
            let dateFormate1 = "dd,MMM,yyyy hh:mm:ss a"
            let dateFormatter1 = DateFormatter()
dateFormatter1.dateFormat = dateFormate1

            let strDate = dateFormatter1.string(from:date)
            self.lblDate.text = strDate

        }

//        let dateFormate = "dd,MMM,yyyy hh:mm:00 a"
//                            let dateFormatter = DateFormatter()
//                            dateFormatter.dateFormat = dateFormate
        
    }
    
}
