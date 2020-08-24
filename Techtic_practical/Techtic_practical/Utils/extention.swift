//
//  extention.swift
//  Techtic_practical
//
//  Created by Kavin Soni on 24/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import Foundation
import UIKit

extension Date {
func app_stringFromDate(dateFormate: String) -> String {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormate
    return dateFormatter.string(from: self)
}
}

extension UIView{
    
    //Corner Round
    func setRoundCorner(radius : CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    func addDropShadow() -> Void {
         
         self.layer.masksToBounds = false;
         self.layer.shadowOffset = CGSize.init(width: 0, height: 0);
         self.layer.shadowRadius = 3;
         self.layer.shadowColor = UIColor.black.cgColor
         self.layer.shadowOpacity = 0.25;
     }
   
}
