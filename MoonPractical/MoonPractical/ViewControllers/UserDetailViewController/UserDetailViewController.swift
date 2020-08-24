//
//  UserDetailViewController.swift
//  MoonPractical
//
//  Created by Kavin Soni on 21/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    //Variable
    
    var objUser:UserModel?
    
    
    //OUTLETS
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblBirthdate: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    func setupUI() -> Void {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        self.title = "Details"
        
        DispatchQueue.main.async {
            self.btnEdit.layer.cornerRadius = 10
            self.btnEdit.clipsToBounds = true
            
            self.imgUser.layer.cornerRadius = self.imgUser.frame.size.width/2
            self.imgUser.clipsToBounds = true
        }
        setUserData()
    }
    
    func setUserData() -> Void {
        self.lblName.text = objUser?.full_name ?? "N/A"
        self.lblEmail.text = objUser?.email ?? "N/A"
        self.lblPhone.text = objUser?.phone ?? "N/A"
        self.lblGender.text = objUser?.gender ?? "N/A"
        self.lblSalary.text = objUser?.salary ?? "N/A"
        self.lblAddress.text = objUser?.address ?? "N/A"
        self.lblBirthdate.text = objUser?.dob ?? "N/A"
        self.lblDestination.text = objUser?.designation ?? "N/A"
        self.lblFullName.text = objUser?.full_name ?? "N/A"
        self.imgUser.sd_setImage(with: URL(string: objUser!.profilePicUrl), placeholderImage: UIImage(named: "placeholder"))

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
