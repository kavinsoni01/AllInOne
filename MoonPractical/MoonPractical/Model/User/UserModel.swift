//
//  UserModel.swift
//  MoonPractical
//
//  Created by Kavin Soni on 21/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit

class UserModel: NSObject {

    var profilePicUrl:String = ""
    
    var id:Int = 0
    
    var full_name:String = ""
    var email:String = ""
    var profile_pic:String = ""
    var phone:String = ""
    var address:String = ""
    var dob:String = ""
    var gender:String = ""
    var designation:String = ""
    var salary:String = ""
    
    var created_at:String = ""
    var updated_at:String = ""

    init(dic:[String:Any]) {
        if let value = dic["profile_pic_url"] as? String{
            self.profilePicUrl = value
        }
        
        if let value = dic["id"] as? Int{
                   self.id = value
               }
        
        if let value = dic["full_name"] as? String{
                   self.full_name = value
               }
        if let value = dic["email"] as? String{
                         self.email = value
                     }
        
        if let value = dic["phone"] as? String{
                   self.phone = value
               }
        
        if let value = dic["address"] as? String{
                   self.address = value
               }
        if let value = dic["dob"] as? String{
                   self.dob = value
               }
        
        if let value = dic["gender"] as? String{
                   self.gender = value
               }
        if let value = dic["designation"] as? String{
                   self.designation = value
               }
        if let value = dic["salary"] as? Double{
                   self.salary = "\(value)"
               }
        if let value = dic["created_at"] as? String{
                   self.created_at = value
               }
        
        if let value = dic["updated_at"] as? String{
                self.updated_at = value
            }
    }
   
    
    init(coredataDict:User) {
        if let value = coredataDict.profile_pic {
              self.profilePicUrl = value
          }
          
//          if let value = coredataDict.id {
        self.id = Int(coredataDict.id)
//                 }
          
        if let value = coredataDict.fullname {
                     self.full_name = value
                 }
          if let value = coredataDict.fullname {
                           self.email = value
                       }
          
          if let value = coredataDict.phone{
                     self.phone = value
                 }
          
        if let value = coredataDict.address{
                     self.address = value
                 }
        if let value = coredataDict.dob{
                     self.dob = value
                 }
          
        if let value = coredataDict.gender{
                     self.gender = value
                 }
        if let value = coredataDict.designation{
                     self.designation = value
                 }
        if let value = coredataDict.salary{
                     self.salary = value
                 }
        if let value = coredataDict.createdate{
                     self.created_at = value
                 }
          
        if let value = coredataDict.updatedat{
                            self.updated_at = value
              }
      }
    
//    "profile_pic_url":"http:\/\/beta3.moontechnolabs.com\/app_practical_api\/public\/storage\/gallery\/No_Image_Available.jpg",
//            "id":93,
//            "full_name":"lynch38",
//            "email":"lynch38@gmail.com",
//            "profile_pic":"No_Image_Available.jpg",
//            "phone":"9876543210",
//            "address":"SG highway",
//            "dob":"2002-07-12",
//            "gender":"male",
//            "designation":"TL",
//            "salary":50000,
//            "created_at":"2020-03-20 09:32:49",
//            "updated_at":"2020-03-20 09:32:49"
    
}
