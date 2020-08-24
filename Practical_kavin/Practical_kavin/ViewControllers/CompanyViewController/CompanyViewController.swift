//
//  CompanyViewController.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 23/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit

class CompanyViewController: BaseViewController,UITableViewDelegate , UITableViewDataSource  {
   
    //VARIABLE
    var arrCompany:[Company] = []
    
    //OUTLETS
    
    @IBOutlet weak var txtCompany: AIFloatingLabelTextField!{
        didSet{
    
            txtCompany.keyboardType = .default
            txtCompany.textColor = UIColor.themeTextGrayColor
            txtCompany.config.placeholderColor = UIColor.themeTextGrayColor
            txtCompany.selectedLineColor = UIColor.themeTextGrayColor
            txtCompany.titleColor = UIColor.themeTextGrayColor
            txtCompany.tintColor = UIColor.themeTextGrayColor
            txtCompany.font = UIFont.appFont_RobotoRegular(Size: 12)
        }
    }
    
    @IBOutlet weak var btnAdd: IVButton!{
        didSet{
            btnAdd.btnType = .grayButton
        }
    }
    @IBOutlet weak var tblCompany: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    //MARK:Setup UI
    func setupUI() -> Void {
        
        self.backButtonType = .backArrow
        self.setGreyNavigationBar()
        self.title = "Company"
        self.tblCompany.delegate = self
        self.tblCompany.dataSource = self
        self.tblCompany.separatorStyle = .none
        self.tblCompany.register(UINib.init(nibName: "CompanyTableCell", bundle: nil), forCellReuseIdentifier:"CompanyTableCell")
        
        self.tblCompany.register(UINib.init(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier:"HeaderCell")
        self.reloadCompanyData()
    }
    

    @IBAction func btnAddClicked(_ sender: Any) {
        
        if txtCompany.text?.isEmpty == true {
            self.showAlertWithTitleFromVC(vc: self, andMessage: "Please enter company name.")
        }else{
            CoreDataManager.shared.addComnapyIntoCoredata(txtCompany.text!) { [unowned self](isSuccess) in
                self.txtCompany.text = ""
                self.reloadCompanyData()
            }
        }
    }

    func reloadCompanyData() -> Void {
        CoreDataManager.shared.retriveCompanyDataFromCoreData { [unowned self](arr) in
            self.arrCompany = [];
            self.arrCompany = arr
            DispatchQueue.main.async {
                self.tblCompany.reloadData()
            }
        }
    }
    
    //MARK: Tableview methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            headerCell.lblTitle.text = "List of companies"
              return headerCell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCompany.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CompanyTableCell = tableView.dequeueReusableCell(withIdentifier: "CompanyTableCell") as! CompanyTableCell
        cell.selectionStyle = .none
        cell.setupCompanyCell(company: arrCompany[indexPath.row])
        cell.isCategory = false
        cell.company = arrCompany[indexPath.row]

        cell.blockDeleteCompanyClicked = { [unowned self] (company) in
            self.deleteCompany(model: company)
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
    

    
    func deleteCompany(model:Company) -> Void {

          
          let alert = UIAlertController(title: "Practical", message: "Are you sure? You want to delete \(model.name!)", preferredStyle: .actionSheet)

                 alert.addAction(UIAlertAction(title: "Delete", style: .default , handler:{ (UIAlertAction)in

                  CoreDataManager.shared.deleteCompany(model) { [unowned self](isSuccess) in
                             if isSuccess == true{
                                 self.reloadCompanyData()
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

