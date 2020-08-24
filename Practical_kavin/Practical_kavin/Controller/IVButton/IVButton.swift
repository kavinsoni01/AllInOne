//
//  IVButton.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 22/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit


enum buttonType {
    case none
    case grayButton
    case imageUpload

}

class IVButton: UIButton {

    var btnType:buttonType = .none

    //INIT
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            commonInit()
        }
        
        private func commonInit()
        {
            self.isExclusiveTouch = true
            
            switch btnType {
            
            case .none:
                     self.titleLabel?.font = UIFont.appFont_RobotoRegular(Size: CGFloat(self.titleLabel?.font.pointSize ?? 15.0))
                
            case .grayButton:
                
                self.titleLabel?.font = UIFont.appFont_RobotoRegular(Size: CGFloat(self.titleLabel?.font.pointSize ?? 15.0))
               

                DispatchQueue.main.async {

                    self.backgroundColor = UIColor.themeDarkGrayColor
                    self.layer.cornerRadius = 10
                    self.clipsToBounds = true
                    self.setTitleColor(UIColor.white, for: .normal)
                    self.setTitleColor(UIColor.white, for: .selected)
               
                }
                
          
            case .imageUpload:
                
                             self.titleLabel?.font = UIFont.appFont_RobotoRegular(Size: CGFloat(self.titleLabel?.font.pointSize ?? 15.0))
                            

                             DispatchQueue.main.async {

                                 self.backgroundColor = UIColor.white
                                 self.layer.cornerRadius = 10
                                 self.clipsToBounds = true
                                 self.setTitleColor(UIColor.themeDarkGrayColor, for: .normal)
                                 self.setTitleColor(UIColor.themeDarkGrayColor, for: .selected)
                                self.layer.borderColor = UIColor.themeDarkGrayColor.cgColor
                                self.layer.borderWidth = 1.0
                                
                             }
            }
            
    }
}
