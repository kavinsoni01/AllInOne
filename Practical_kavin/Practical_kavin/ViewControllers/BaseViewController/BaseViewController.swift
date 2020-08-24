//
//  BaseViewController.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 22/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.preferredStatusBarStyle = UIStatusBarStyle.lightContent
        // Do any additional setup after loading the view.
    }
    
        func setNormalNavigationBar(){
            self.navigationController?.navigationBar.isTranslucent = false
        }

        func setGreyNavigationBar() -> Void {
                 
       
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.view.backgroundColor = UIColor.themeDarkGrayColor
            self.navigationController?.navigationBar.backgroundColor = UIColor.themeDarkGrayColor
            self.navigationController?.navigationBar.isTranslucent = true
            
            let navBarAppearance = UINavigationBarAppearance()
               navBarAppearance.configureWithOpaqueBackground()
               navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont.appFont_RobotoBold(Size: 18)]
               navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
               navBarAppearance.backgroundColor = UIColor.themeDarkGrayColor
               self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            
               self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont.appFont_RobotoBold(Size: 18)]

//            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
//            statusBar.backgroundColor = UIColor.systemBackground
//            UIApplication.shared.keyWindow?.addSubview(statusBar)

            
        }
      
        
        override var preferredStatusBarStyle : UIStatusBarStyle {
            return .lightContent
        }
        
        
        var backButtonType: LeftBarButtonType = LeftBarButtonType.none {
            didSet {
                switch backButtonType {
            
                case .none:
                    self.navigationItem.hidesBackButton = true

                case .backArrow  :
                    let buttonLeftBar = UIButton(type: UIButton.ButtonType.custom) as UIButton
                    buttonLeftBar.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
                    buttonLeftBar.setImage(UIImage(named: self.backButtonType.imageName), for: .normal)
                    buttonLeftBar.addTarget(self, action: #selector(self.buttonBackPressed(sender:)), for: .touchUpInside)
                    buttonLeftBar.contentHorizontalAlignment = .left
                    buttonLeftBar.contentHorizontalAlignment = .left
                    let item = UIBarButtonItem(customView: buttonLeftBar)
                    self.navigationItem.leftBarButtonItem = item
            

                }
            }
        }
        
        
        
        
        // MARK:- BAR BUTTON HANDLERS
        @objc func buttonBackPressed(sender:UIButton) {

            switch self.backButtonType {


            case .backArrow:
                _ = self.navigationController?.popViewController(animated: true)
            case .none:
                break

            }
        }
        
        
        var rightButtonType: RightBarButtonType = RightBarButtonType.none {
            didSet {
                switch rightButtonType {
                case .none:
                    self.navigationItem.hidesBackButton = true

                case .add:

                    let buttonLeftBar = UIButton(type: UIButton.ButtonType.custom) as UIButton
                                   buttonLeftBar.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
                                   buttonLeftBar.setImage(UIImage(named: self.rightButtonType.imageName), for: .normal)
                                   buttonLeftBar.addTarget(self, action: #selector(self.buttonRightPressed(sender:)), for: .touchUpInside)
                                   buttonLeftBar.contentHorizontalAlignment = .right



                    DispatchQueue.main.async {
                                            buttonLeftBar.layer.masksToBounds = false;
                                            buttonLeftBar.layer.shadowOffset = CGSize.init(width: 0, height: 0);
                                            buttonLeftBar.layer.shadowRadius = 5;
                                            buttonLeftBar.layer.shadowColor = UIColor.black.cgColor
                                            buttonLeftBar.layer.shadowOpacity = 0.9;
                                  }

                    let item = UIBarButtonItem(customView: buttonLeftBar)
                    self.navigationItem.rightBarButtonItem = item


              

                }


            }
        }
        
        // MARK:- BAR BUTTON HANDLERS
        @objc func buttonRightPressed(sender:UIButton) {

            switch self.rightButtonType {
            case .add:
                break
          
            case .none:
                break


            }
        }
        
   


        
    }




    //MARK:- AILeftBarButtonType
    enum LeftBarButtonType: Int {
        
        case  backArrow, none
        
        var imageName: String {
            switch self {
                
                
            case .backArrow:
                return "back"
            
          
            case .none:
                return ""
                
           
                
            }
        }
        
        var buttonTitle: String {
            switch self {
                
          
            case .backArrow:
                return ""
            case .none:
                return ""
          

            }
        }
    }


    //MARK:- AIRightBarButtonType
    enum RightBarButtonType: Int {
        
        case add,none
        
        var imageName: String {
            switch self {
            case .add:
                return "add"
          
            case .none:
                return ""
                          
            }
        }
        
        var buttonTitle: String {
            switch self {
                                
            case .add:
               return ""
            case .none:
               return ""
          
            }
            
            
        }
        

        
    }
