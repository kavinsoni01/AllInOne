//
//  ProductListViewController.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 22/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit
import CoreData

class ProductListViewController: BaseViewController , UITableViewDelegate,UITableViewDataSource{
   
    //VARIABLES
    
    var arrProduct:[Product] = []

    
    //OUTLETS
    @IBOutlet weak var tblProduct: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.retriveDataFromCoreData()
    }
   //MARK:Setup UI
    
    func setupUI() -> Void {
        self.title = "Products"
        self.backButtonType = .backArrow
        self.rightButtonType = .add
        self.setGreyNavigationBar()
        self.tblProduct.delegate = self
        self.tblProduct.dataSource = self
        self.tblProduct.separatorStyle = .none
        self.tblProduct.register(UINib.init(nibName: "ProductTableCell", bundle: nil), forCellReuseIdentifier: "ProductTableCell")
       }

    
    override func buttonRightPressed(sender: UIButton) {
        let productAdd = (self.storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as! AddProductViewController)
               self.navigationController?.pushViewController(productAdd, animated: true)
    }

    //MARK: Tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
        return arrProduct.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProductTableCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableCell") as! ProductTableCell
        cell.selectionStyle = .none
        cell.selectedModel = arrProduct[indexPath.row]
        cell.setupCell(product: arrProduct[indexPath.row])
        cell.btnEdit.tag = indexPath.row
        
        
        cell.blockEditClicked = { [unowned self](selectedProduct) in
            self.pushToEditViewController(model: selectedProduct)
            
        }
        cell.blockDeleteClicked = { [unowned self](selectedProduct) in
//
            self.deleteButtonClicked(model: selectedProduct)
        }
        
        
        return cell
       }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail:ProductDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
            detail.productModel = arrProduct[indexPath.row]
             self.navigationController?.pushViewController(detail, animated: true)
    }

//MARK: Push To Edit View Controller
    func pushToEditViewController(model:Product) {
        let editView:AddProductViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddProductViewController") as! AddProductViewController
        editView.isEdit = true
        editView.passModel = model
        self.navigationController?.pushViewController(editView, animated: true)
    }
    
    //MARK: Delete Product
    func deleteButtonClicked(model:Product) -> Void {
        
        let alert = UIAlertController(title: "Practical", message: "Are you sure? You want to delete \(model.name!)", preferredStyle: .actionSheet)

               alert.addAction(UIAlertAction(title: "Delete", style: .default , handler:{ (UIAlertAction)in

                CoreDataManager.shared.deleteProduct(model) { [unowned self](isSuccess) in
                           if isSuccess == true{
                               self.retriveDataFromCoreData()
                           }
                       }
               }))
            
               alert.addAction(UIAlertAction(title: "Cancel", style: .destructive , handler:{ (UIAlertAction)in

               }))

               self.present(alert, animated: true, completion: {
                   print("completion block")
               })
        
    }
    
    
    //MARK: Retrive Data
    func retriveDataFromCoreData() -> Void {
        CoreDataManager.shared.retriveDataFromCoreData { [unowned self] (arrProduct) in
            self.arrProduct = arrProduct
            DispatchQueue.main.async {
                self.tblProduct.reloadData()
            }
        }

    }
    
}
