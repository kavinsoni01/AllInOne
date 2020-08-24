//
//  AddProductViewController.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 22/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit
import CoreData

class AddProductViewController: BaseViewController , ImagePickerDelegate{

    //VARIABLES
    var image1:UIImage?
    var image2:UIImage?
    var image3:UIImage?
    var image4:UIImage?
    var selectedImage = 0
    var passModel:Product?
    var isEdit:Bool?
    var arrCompany:[Company] = []
    var arrCategory:[Category] = []
    
    private lazy var imagePicker: ImagePicker = {
           let imagePicker = ImagePicker()
           imagePicker.delegate = self
           return imagePicker
       }()
    
    
    //OUTLETS
    @IBOutlet weak var btnSave: IVButton!{
        didSet{
            btnSave.btnType = .grayButton
        }
    }
    @IBOutlet weak var lblDescStatic: IVLabel!{
        didSet{
            lblDescStatic.textColor = UIColor.themeDarkGrayColor
        }
    }
    
    @IBOutlet weak var btnImg4: IVButton!{
        didSet{
            btnImg4.btnType = .imageUpload
        }
    }
    @IBOutlet weak var btnImg3: IVButton!{
        didSet{
            btnImg3.btnType = .imageUpload
        }
    }
    @IBOutlet weak var btnImg2: IVButton!{
        didSet{
            btnImg2.btnType = .imageUpload
        }
    }
    @IBOutlet weak var btnImg1: IVButton!{
        didSet{
            btnImg1.btnType = .imageUpload
        }
    }
    @IBOutlet weak var lblStaticUploadImage: IVLabel!{
        didSet{
            lblStaticUploadImage.textColor = UIColor.themeTextGrayColor
        }
    }
    
    @IBOutlet weak var txtQty: AIFloatingLabelTextField!
    {
        didSet{
        
            txtQty.keyboardType = .numberPad
               txtQty.textColor = UIColor.themeTextGrayColor
            txtQty.config.placeholderColor = UIColor.themeTextGrayColor
               txtQty.selectedLineColor = UIColor.themeTextGrayColor
               txtQty.titleColor = UIColor.themeTextGrayColor
               txtQty.tintColor = UIColor.themeTextGrayColor
            txtQty.font = UIFont.appFont_RobotoRegular(Size: 12)

        }
    }
    @IBOutlet weak var txtPrice: AIFloatingLabelTextField!{
        didSet{
        
                txtPrice.keyboardType = .numberPad
               txtPrice.textColor = UIColor.themeTextGrayColor
               txtPrice.config.placeholderColor = UIColor.themeTextGrayColor
               txtPrice.selectedLineColor = UIColor.themeTextGrayColor
               txtPrice.titleColor = UIColor.themeTextGrayColor
               txtPrice.tintColor = UIColor.themeTextGrayColor
            txtPrice.font = UIFont.appFont_RobotoRegular(Size: 12)

        }
    }
    @IBOutlet weak var txtDescription: UITextView!{
        didSet{
                txtDescription.keyboardType = .default
               txtDescription.textColor = UIColor.themeTextGrayColor
               txtDescription.tintColor = UIColor.themeTextGrayColor
        }
    }
    @IBOutlet weak var txtCompany: AIFloatingLabelTextFieldPickerView!{
        didSet{
        
            txtCompany.keyboardType = .default
            txtCompany.config.textColor = UIColor.themeTextGrayColor
            txtCompany.config.placeholderColor = UIColor.themeTextGrayColor
            txtCompany.selectedLineColor = UIColor.themeTextGrayColor
            txtCompany.titleColor = UIColor.themeTextGrayColor
            txtCompany.tintColor = UIColor.themeTextGrayColor
            txtCompany.font = UIFont.appFont_RobotoRegular(Size: 12)
        }
    }
    
    @IBOutlet weak var txtCategory: AIFloatingLabelTextFieldPickerView!{
        didSet{
        
            txtCategory.keyboardType = .default
            txtCategory.config.textColor = UIColor.themeTextGrayColor
            txtCategory.config.placeholderColor = UIColor.themeTextGrayColor

               txtCategory.selectedLineColor = UIColor.themeTextGrayColor
               txtCategory.titleColor = UIColor.themeTextGrayColor
               txtCategory.tintColor = UIColor.themeTextGrayColor
            txtCategory.font = UIFont.appFont_RobotoRegular(Size: 12)

        }
    }
    
    @IBOutlet weak var txtProductName: AIFloatingLabelTextField!{
        didSet{
        
            txtProductName.keyboardType = .default
               txtProductName.textColor = UIColor.themeTextGrayColor
            txtProductName.config.placeholderColor = UIColor.themeTextGrayColor
               txtProductName.selectedLineColor = UIColor.themeTextGrayColor
               txtProductName.titleColor = UIColor.themeTextGrayColor
               txtProductName.tintColor = UIColor.themeTextGrayColor
            txtProductName.font = UIFont.appFont_RobotoRegular(Size: 12)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    
    

    func setupUI() -> Void {
        self.title = "Add Products"
        self.setGreyNavigationBar()
        self.backButtonType = .backArrow
        DispatchQueue.main.async {
            self.txtDescription.layer.borderWidth = 1.0
            self.txtDescription.layer.borderColor = UIColor.themeDarkGrayColor.cgColor
            self.txtDescription.layer.cornerRadius = 5
            self.txtDescription.clipsToBounds = true
        }
        if isEdit == true{
            self.setDataForEdit()
        }
        
        txtCategory.pickerViewdidSelectRowHandler = { [unowned self] (txtField, selectedIndex) in
            self.txtCategory.text = self.arrCategory[selectedIndex].name
             }
             
             txtCategory.pickerViewDoneHandler = { [unowned self] (txtField, selectedIndex) in
                self.txtCategory.text = self.arrCategory[selectedIndex].name
             }
        
            txtCompany.pickerViewdidSelectRowHandler = { [unowned self] (txtField, selectedIndex) in
                    self.txtCompany.text = self.arrCompany[selectedIndex].name
             }
             
             txtCompany.pickerViewDoneHandler = { [unowned self] (txtField, selectedIndex) in
                 self.txtCompany.text = self.arrCompany[selectedIndex].name

             }
        
        self.LoadCompanyData()
        self.LoadCategoryData()
    }
    
    
    func LoadCategoryData() -> Void {
         CoreDataManager.shared.retriveCategoryDataFromCoreData{ [unowned self](arr) in
            self.txtCategory.arrInput = arr.map({$0.name!})
            self.arrCategory = arr
         }
     }

    
    
    func LoadCompanyData() -> Void {
         CoreDataManager.shared.retriveCompanyDataFromCoreData{ [unowned self](arr) in
            self.txtCompany.arrInput = arr.map({($0.name!)})
            self.arrCompany = arr
        }
     }

    
    
    func setDataForEdit()  {
        self.txtPrice.text = passModel?.price
        self.txtCategory.text = passModel?.category
        self.txtCompany.text = passModel?.company
        self.txtProductName.text = passModel?.name
        self.txtDescription.text = passModel?.productdescription
        self.txtQty.text = passModel?.qty
        if ((passModel?.image1) != nil){
            image1 = UIImage.init(data: passModel!.image1!)
            self.btnImg1.setImage(image1, for: .normal)
        }
        
        if ((passModel?.image2) != nil){
            image2 = UIImage.init(data: passModel!.image2!)
            self.btnImg2.setImage(image2, for: .normal)
            }
        
        if ((passModel?.image3) != nil){
            image3 = UIImage.init(data: passModel!.image3!)
                   self.btnImg3.setImage(image3, for: .normal)
               }
        
        if ((passModel?.image4) != nil){
            image4 = UIImage.init(data: passModel!.image4!)
                   self.btnImg4.setImage(image4, for: .normal)
               }
    }
    
//MARK: Button Actions
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        if isEdit == true{
            if checkValidation() == true {
                CoreDataManager.shared.updateDataIntoCoredata(passModel!, productName: txtProductName.text!, category: txtCategory.text!, company: txtCompany.text!, description: txtDescription.text!, qty: txtQty.text!, price: txtPrice.text!, image1: image1, image2: image2, image3: image3, image4: image4) { [unowned self](isSuccess) in
                    
                    
                    self.navigationController?.popViewController(animated: true)

//                    self.showAlertWithTitleFromVC(vc: self, andMessage: "Data updated Successfully.")
                }
            }
            
        }else{
            
            if checkValidation() == true {
                CoreDataManager.shared.addProductIntoCoredata(txtProductName.text!, category: txtCategory.text!, company: txtCompany.text!, description: txtDescription.text!, qty: txtQty.text!, price: txtPrice.text!, image1: image1, image2: image2, image3: image3, image4: image4) { [unowned self](isSuccess) in
                    self.navigationController?.popViewController(animated: true)

//                    self.showAlertWithTitleFromVC(vc: self, andMessage: "Data added Successfully.")
                }
            }

        }
    }
    
    @IBAction func btnImage1Ckiced(_ sender: Any) {
        selectedImage = 0
        openCameraOrPhotos()
    }
    
    @IBAction func btnImage2Clicked(_ sender: Any) {
        selectedImage = 1
        openCameraOrPhotos()
    }
    
    @IBAction func btnImage3Clicked(_ sender: Any) {
        selectedImage = 2
        openCameraOrPhotos()
    }
    
    @IBAction func btnImageClicked(_ sender: Any) {
        selectedImage = 3
        openCameraOrPhotos()
    }
    
    func openCameraOrPhotos() -> Void {
        let alert = UIAlertController(title: "Practical", message: "Please Select an Option", preferredStyle: .actionSheet)

               alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
                   self.cameraButtonTapped()
               }))

               alert.addAction(UIAlertAction(title: "Photos", style: .default , handler:{ (UIAlertAction)in
                   self.photoButtonTapped()
               }))

               alert.addAction(UIAlertAction(title: "Cancel", style: .destructive , handler:{ (UIAlertAction)in

               }))

              

               self.present(alert, animated: true, completion: {
                   print("completion block")
               })
        
    }
    //Image Picker
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
       
        if selectedImage == 0{
            image1 = image
            btnImg1.setImage(image, for: .normal)

            
        }else if selectedImage == 1
        {
            image2 = image
            btnImg2.setImage(image, for: .normal)

        }else if selectedImage == 2
        {
            image3 = image
            btnImg3.setImage(image, for: .normal)

        }else if selectedImage == 3
        {
            image4 = image
            btnImg4.setImage(image, for: .normal)

        }
           imagePicker.dismiss()
       }

    
    func photoButtonTapped() { imagePicker.photoGalleryAsscessRequest() }
    func cameraButtonTapped() { imagePicker.cameraAsscessRequest() }
    
    
       func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss() }
    
    
       func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                        to sourceType: UIImagePickerController.SourceType) {
           guard grantedAccess else { return }
           imagePicker.present(parent: self, sourceType: sourceType)
       }
    
    
    //MARK:Validation
    
    func checkValidation() -> Bool {
        
        var imgCount = 0
              if (image1 != nil){
                  imgCount = imgCount+1
              }
              if (image2 != nil){
                  imgCount = imgCount+1

              }
              if (image3 != nil){
                  imgCount = imgCount+1

              }
              if (image4 != nil){
                  imgCount = imgCount+1

              }
        
        if txtProductName.text?.isEmpty == true{
            showAlertWithTitleFromVC(vc: self, andMessage: "Please enter product name.")
            return false

        }else if txtCategory.text?.isEmpty == true{
            showAlertWithTitleFromVC(vc: self, andMessage: "Please enter category.")
            return false

        }else if txtCompany.text?.isEmpty == true{
            showAlertWithTitleFromVC(vc: self, andMessage: "Please enter company.")
            return false

        }else if txtDescription.text?.isEmpty == true{
            showAlertWithTitleFromVC(vc: self, andMessage: "Please enter description.")
            return false

        }else if txtPrice.text?.isEmpty == true{
            showAlertWithTitleFromVC(vc: self, andMessage: "Please enter price.")
            return false

        }else if txtQty.text?.isEmpty == true{
            showAlertWithTitleFromVC(vc: self, andMessage: "Please enter quantity.")
            return false
        }else if imgCount < 2{
            showAlertWithTitleFromVC(vc: self, andMessage: "Please upload minimum 2 images.")
            return false
        }
      
            
            
        else{
            return true
        }
        
    }

      
        
     
        
    
}
