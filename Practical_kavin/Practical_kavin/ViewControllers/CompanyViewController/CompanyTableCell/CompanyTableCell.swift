//
//  CompanyTableCell.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 23/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit

typealias DeleteCategory = ((_ category:Category)->(Void))
typealias DeleteCompany = ((_ company:Company)->(Void))

    

    
class CompanyTableCell: UITableViewCell {
    
    var blockDeleteCategoryClicked:DeleteCategory?
    var blockDeleteCompanyClicked:DeleteCompany?
    
    var isCategory:Bool?
    var category:Category?
    var company:Company?
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var lblTitle: IVLabel!
    {
        didSet{
            lblTitle.textColor = UIColor.white
        }
    }
    @IBOutlet weak var btnDelete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.viewBack.backgroundColor = UIColor.themeDarkGrayColor
            self.viewBack.layer.cornerRadius = 10
            self.viewBack.clipsToBounds = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCompanyCell(company:Company) -> Void {
        self.lblTitle.text = company.name
    }
    
    func setupCetogoryCell(category:Category) -> Void {
           self.lblTitle.text = category.name
    }
    
    @IBAction func btnDeleteClicked(_ sender: Any) {
        
        if isCategory ==  true{
            if blockDeleteCategoryClicked != nil {
                self.blockDeleteCategoryClicked!(category!)
            }
        }else{
            if blockDeleteCompanyClicked != nil {
                self.blockDeleteCompanyClicked!(company!)
            }
        }
    }
    
}
