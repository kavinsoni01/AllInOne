//
//  ProductDetailViewController.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 22/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//


import UIKit

class ImageCollectionView: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.autoresizingMask =  [.flexibleWidth, .flexibleTopMargin]
        self.imgView.layer.cornerRadius = 5
        self.imgView.clipsToBounds = true
    }

}
