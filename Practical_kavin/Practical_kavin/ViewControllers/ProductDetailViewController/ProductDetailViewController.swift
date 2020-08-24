//
//  ProductDetailViewController.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 22/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit
import CoreData

class ProductDetailViewController: BaseViewController, UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //VARIABLE
    
    var productModel:Product?
    var timer:Timer? = nil
    var arrImages:[UIImage] = []
    
    //OUTLETS
    @IBOutlet weak var lblProductLine: IVLabel!{
        didSet{
            lblProductLine.textColor = UIColor.themeTextGrayColor
        }
    }
    @IBOutlet weak var lblDesc: IVLabel!{
        didSet{
            lblDesc.textColor = UIColor.themeTextGrayColor
        }
    }
    @IBOutlet weak var pageView: UIPageControl!
    
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
    @IBOutlet weak var lblDescriptionStatic: IVLabel!{
        didSet{
            lblDescriptionStatic.textColor = UIColor.themeTextGrayColor
            lblDescriptionStatic.fontStyle = .RobotoMedium

        }
    }
    @IBOutlet weak var lblProductName: IVLabel!{
        didSet{
            lblProductName.textColor = UIColor.themeTextGrayColor
            lblProductName.fontStyle = .RobotoMedium
        }
    }
//    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
  
    
    @IBOutlet weak var lblQty: IVLabel!{
        didSet{
            lblQty.textColor = UIColor.themeTextGrayColor
            lblQty.fontStyle = .RobotoRegular
        }
    }
    @IBOutlet weak var lblCompany: IVLabel!{
        didSet{
            lblCompany.textColor = UIColor.themeTextGrayColor
            lblCompany.fontStyle = .RobotoMedium
        }
    }
    
    @IBOutlet weak var viewPage: UIPageControl!
    @IBOutlet weak var lblPrice: IVLabel!{
        didSet{
            lblPrice.textColor = UIColor.themeTextGrayColor
            lblPrice.fontStyle = .RobotoRegular
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    //MARK: Setup UI
    
    func setupUI() -> Void {
        
       
        self.collectionView.register(UINib.init(nibName: "ImageCollectionView", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionView")
        self.title = "Products Detail"
        self.backButtonType = .backArrow
        self.setGreyNavigationBar()
        pageView.currentPage = 0        
        self.countImages()
//        self.setData()
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CoreDataManager.shared.retriveSingleProductFromCoreData(productModel!) { [unowned self](product) in
                         self.productModel = product
                         self.setData()
                     }
    }
    //MARK: Set Data
    func setData() -> Void {
        lblProductName.text = productModel?.name
        
        let mediamAttribute = [ NSAttributedString.Key.font: UIFont.appFont_RobotoMedium(Size: 14)]
        let qtyString = NSMutableAttributedString(string: "Qty: ", attributes: mediamAttribute)
        let attrQtyString = NSAttributedString(string: (productModel?.qty!)!)
        qtyString.append(attrQtyString)
        lblQty.attributedText = qtyString
        
        
               let priceString = NSMutableAttributedString(string: "Price: ", attributes: mediamAttribute)
               let attrPriceString = NSAttributedString(string: (productModel?.price!)!)
               priceString.append(attrPriceString)
               lblPrice.attributedText = priceString
        
        lblDesc.text = productModel?.productdescription
        lblCompany.text = productModel?.company
        lblProductLine.text = productModel?.category
    }
//MARK: Count image and add into array
    
    func countImages() -> Void {
        arrImages = []
        if ((productModel?.image1) != nil) {
            arrImages.append(UIImage.init(data:(productModel?.image1!)!)!)
        }
        if ((productModel?.image2) != nil) {
            arrImages.append(UIImage.init(data:productModel!.image2!)!)
            }
        if ((productModel?.image3) != nil) {
            arrImages.append(UIImage.init(data:productModel!.image3!)!)
            }
        if ((productModel?.image4) != nil) {
            arrImages.append(UIImage.init(data:productModel!.image4!)!)
        }
            
        pageView.numberOfPages = arrImages.count
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.reloadCollectionView()

    }
        
    @IBAction func btnDeleteClicked(_ sender: Any) {
        self.deleteButtonClicked(model: self.productModel!)
    }
    
    @IBAction func btnEditClicked(_ sender: Any) {
        self.pushToEditViewController(model: self.productModel!)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer?.invalidate()
    }
    
    deinit {
        self.timer?.invalidate()
    }
    
    //Set Page Controller
    

    
    
    //Auto Scroll ImageView
       func reloadCollectionView() {
           // Invalidating timer for safety reasons
           self.timer?.invalidate()
           
       self.timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(self.autoScrollImageSlider), userInfo: nil, repeats: true)

       }

       func scrollToPreviousOrNextCell(direction: String) {

               DispatchQueue.global(qos: .background).async {

                   DispatchQueue.main.async {

                       let firstIndex = 0
                       let lastIndex = (self.arrImages.count) - 1

                       let visibleIndices = self.collectionView.indexPathsForVisibleItems

                       let nextIndex = visibleIndices[0].row + 1
                       let previousIndex = visibleIndices[0].row - 1

                       let nextIndexPath: IndexPath = IndexPath.init(item: nextIndex, section: 0)
                       let previousIndexPath: IndexPath = IndexPath.init(item: previousIndex, section: 0)

                       if direction == "Previous" {

                           if previousIndex < firstIndex {


                           } else {

                               self.collectionView.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
                           }

                       } else if direction == "Next" {

                           if nextIndex > lastIndex {


                           } else {

                               self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)

                           }

                       }

                   }

               }

           }

       @objc func autoScrollImageSlider() {
               DispatchQueue.global(qos: .background).async {

                   DispatchQueue.main.async {

                       let firstIndex = 0
                       let lastIndex = (self.arrImages.count) - 1

                       let visibleIndices = self.collectionView.indexPathsForVisibleItems
                       if visibleIndices.count > 0 {
                       let nextIndex = visibleIndices[0].row + 1
                       let nextIndexPath: IndexPath = IndexPath.init(item: nextIndex, section: 0)
                       let firstIndexPath: IndexPath = IndexPath.init(item: firstIndex, section: 0)

                       if nextIndex > lastIndex {
                           self.collectionView.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: true)
                       }else{
                           self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                       }
                       }
                   }

               }

           }

       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return self.arrImages.count
       }
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           collectionView.isPagingEnabled = true;      //makes the horizontal scrolling have no bounce and relatively have a better snap
           //Use your custom cell
           let cell:ImageCollectionView = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionView", for: indexPath) as! ImageCollectionView
            cell.imgView.image = arrImages[indexPath.row]
           return cell

       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
           print(CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height))
           return CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
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
                                self.navigationController?.popToRootViewController(animated: true)
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
