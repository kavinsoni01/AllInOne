//
//  HomeViewController.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 22/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var btnProduct: IVButton!{
        didSet{
            btnProduct.btnType = .grayButton
        }
    }
    @IBOutlet weak var btnManageCompany: IVButton!{
        didSet{
            btnManageCompany.btnType = .grayButton
        }
    }
    @IBOutlet weak var btnManageCategory: IVButton!{
        didSet{
            btnManageCategory.btnType = .grayButton
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() -> Void {
        self.title = "Home"
        self.backButtonType = .backArrow
        self.setGreyNavigationBar()
    }

   
    
    //MARK: Buttton Action
    @IBAction func btnManageCompany(_ sender: Any) {
        
        let productList = (self.storyboard?.instantiateViewController(withIdentifier: "CompanyViewController") as! CompanyViewController)
              self.navigationController?.pushViewController(productList, animated: true)
    }
    
    @IBAction func btnManageCategory(_ sender: Any) {
        
            let categoryList = (self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController)
                self.navigationController?.pushViewController(categoryList, animated: true)
        
    }
    
    @IBAction func btnProductClicked(_ sender: Any) {
        let companyList = (self.storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController)
        self.navigationController?.pushViewController(companyList, animated: true)
        
    }
}
