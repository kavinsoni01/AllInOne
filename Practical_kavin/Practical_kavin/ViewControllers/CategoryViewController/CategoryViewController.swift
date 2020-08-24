//
//  CategoryViewController.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 23/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit

class CategoryViewController: BaseViewController ,UITableViewDelegate , UITableViewDataSource  {
   
    //VARIABLE
    var arrCategory:[Category] = []
    
    //OUTLETS
    
    @IBOutlet weak var txtCategory: AIFloatingLabelTextField!{
        didSet{
    
            txtCategory.keyboardType = .default
            txtCategory.textColor = UIColor.themeTextGrayColor
            txtCategory.config.placeholderColor = UIColor.themeTextGrayColor
            txtCategory.selectedLineColor = UIColor.themeTextGrayColor
            txtCategory.titleColor = UIColor.themeTextGrayColor
            txtCategory.tintColor = UIColor.themeTextGrayColor
            txtCategory.font = UIFont.appFont_RobotoRegular(Size: 12)
        }
    }
    
    @IBOutlet weak var btnAdd: IVButton!{
        didSet{
            btnAdd.btnType = .grayButton
        }
    }
    @IBOutlet weak var tblCategory: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.reloadCategoryData()
    }
    
    func reloadCategoryData() -> Void {
        CoreDataManager.shared.retriveCategoryDataFromCoreData{ [unowned self](arr) in
            self.arrCategory = []
            self.arrCategory = arr
            DispatchQueue.main.async {
                self.tblCategory.reloadData()
            }
        }
    }

    

    //MARK:Setup UI
    func setupUI() -> Void {
        
        self.backButtonType = .backArrow
        self.setGreyNavigationBar()
        self.title = "Category"
        self.tblCategory.delegate = self
        self.tblCategory.dataSource = self
        self.tblCategory.separatorStyle = .none
        self.tblCategory.register(UINib.init(nibName: "CompanyTableCell", bundle: nil), forCellReuseIdentifier:"CompanyTableCell")
        
        self.tblCategory.register(UINib.init(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier:"HeaderCell")
        
    }
    

    @IBAction func btnAddClicked(_ sender: Any) {
        
        if txtCategory.text?.isEmpty == true {
            self.showAlertWithTitleFromVC(vc: self, andMessage: "Please enter category name.")
        }else{
            CoreDataManager.shared.addCategoryIntoCoredata(txtCategory.text!) { [unowned self](isSuccess) in
                self.txtCategory.text = ""
                self.reloadCategoryData()
            }
        }
    }

    
    //MARK: Tableview methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            headerCell.lblTitle.text = "List of categories"
              return headerCell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCategory.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CompanyTableCell = tableView.dequeueReusableCell(withIdentifier: "CompanyTableCell") as! CompanyTableCell
        cell.selectionStyle = .none
        cell.setupCetogoryCell(category: arrCategory[indexPath.row])
        cell.category = arrCategory[indexPath.row]
        cell.isCategory = true
        
        cell.blockDeleteCategoryClicked = { [unowned self] (company) in
            self.deleteCategory(model: company)
        }
        return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
       
    
    //MARK:Delete company
    

    
    func deleteCategory(model:Category) -> Void {

          
          let alert = UIAlertController(title: "Practical", message: "Are you sure? You want to delete \(model.name!)", preferredStyle: .actionSheet)

                 alert.addAction(UIAlertAction(title: "Delete", style: .default , handler:{ (UIAlertAction)in

                  CoreDataManager.shared.deleteCategory(model) { [unowned self](isSuccess) in
                             if isSuccess == true{
                                self.reloadCategoryData()
                             }
                         }
                 }))

              

                 alert.addAction(UIAlertAction(title: "Cancel", style: .destructive , handler:{ (UIAlertAction)in

                 }))

                

                 self.present(alert, animated: true, completion: {
                     print("completion block")
                 })
      }
}
