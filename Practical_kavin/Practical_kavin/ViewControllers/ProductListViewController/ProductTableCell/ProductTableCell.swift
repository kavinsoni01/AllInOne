//
//  ProductTableCell.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 22/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit

typealias EditClicked = (Product)->(Void)
typealias DeleteClicked = (Product)->(Void)

class ProductTableCell: UITableViewCell {
    
    var blockEditClicked:EditClicked?
    var blockDeleteClicked:DeleteClicked?
    var selectedModel:Product?
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var imgTitle: UIImageView!
    @IBOutlet weak var btnDelete: IVButton!{
        didSet{
            btnDelete.btnType = .grayButton
        }
    }
    
    @IBOutlet weak var btnEdit: IVButton!{
        didSet{
            btnEdit.btnType = .grayButton
        }
    }
    @IBOutlet weak var lblQty: IVLabel!{
         didSet{
            lblQty.textColor = UIColor.themeTextGrayColor
        }
    }
    
    @IBOutlet weak var lblDesc: IVLabel!{
         didSet{
            lblDesc.textColor = UIColor.themeTextGrayColor
        }
    }
    @IBOutlet weak var lblProductName: IVLabel!{
         didSet{
            lblProductName.textColor = UIColor.themeTextGrayColor
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.async {
            self.viewBack.layer.cornerRadius = 10
            self.viewBack.clipsToBounds = true
            self.viewBack.addDropShadow()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(product:Product) -> Void {
        self.lblProductName.text = product.name
        self.lblQty.text = "Qty: \(product.qty ?? "")"
        self.lblDesc.text = product.category
        if (product.image1 != nil){
            self.imgTitle.image =  UIImage(data: product.image1!)
        }else if (product.image2 != nil){
            self.imgTitle.image = UIImage(data: product.image2!)
        }else if (product.image3 != nil){
            self.imgTitle.image = UIImage(data: product.image3!)
        }else if (product.image4 != nil){
            self.imgTitle.image = UIImage(data: product.image4!)
        }

    }
    @IBAction func btnEditClicked(_ sender: Any) {
        if blockEditClicked != nil{
            blockEditClicked!(self.selectedModel!)
        }
    }
    
    @IBAction func btnDeleteClicked(_ sender: Any) {
        if blockDeleteClicked != nil{
            blockDeleteClicked!(self.selectedModel!)
        }
    }
    
}
