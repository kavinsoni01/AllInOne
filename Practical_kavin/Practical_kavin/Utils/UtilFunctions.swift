//
//  UtilFunctions.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 22/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import Foundation
import UIKit




struct Keys {
    
    static let entityProduct = "Product"
    static let category = "category"
    static let id = "id"

    static let company = "company"
    static let image1 = "image1"
    static let image2 = "image2"
    static let image3 = "image3"
    static let image4 = "image4"
    static let name = "name"
    static let price = "price"
    static let productdescription = "productdescription"
    static let qty = "qty"
    
    static let entityCategory = "Category"
    static let entityCompany = "Company"

}




//----------------------------------------------------------------
//MARK:- APPDELEGATE SHARED INSTACE -
let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate


//----------------------------------------------------------------
//MARK:- PROPORTIONAL SIZE -
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
//----------------------------------------------------------------
func GET_PROPORTIONAL_WIDTH (width:CGFloat) -> CGFloat {
//    return ((SCREEN_WIDTH * width)/750)
    return ((SCREEN_WIDTH * width)/375)
}
//----------------------------------------------------------------
func GET_PROPORTIONAL_HEIGHT (height:CGFloat) -> CGFloat {
//    return ((SCREEN_HEIGHT * height)/1334)
    return ((SCREEN_HEIGHT * height)/667)
}

func GET_PROPORTIONAL_HEIGHT_ACCORDING_WIDTH (height:CGFloat) -> CGFloat {
    //    return ((SCREEN_HEIGHT * height)/1334)
    if SCREEN_WIDTH == 375 {
        return height
    }else if SCREEN_WIDTH == 414 {
        return ((736 * height)/667)
    }else{
        return ((SCREEN_HEIGHT * height)/667)
    }
}


//----------------------------------------------------------------
//----------------------------------------------------------------
//MARK:- DEVICE CHECK -
//Check IsiPhone Device
func IS_IPHONE_DEVICE()->Bool{
    let deviceType = UIDevice.current.userInterfaceIdiom == .phone
    return deviceType
}
//----------------------------------------------------------------
//Check IsiPad Device
func IS_IPAD_DEVICE()->Bool{
    let deviceType = UIDevice.current.userInterfaceIdiom == .pad
    return deviceType
}
//----------------------------------------------------------------
//iPhone 4 OR 4S
func IS_IPHONE_4_OR_4S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 480
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}
//----------------------------------------------------------------
//iPhone 5 OR OR 5C OR 4S
func IS_IPHONE_5_OR_5S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 568
    var device:Bool = false
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}
//----------------------------------------------------------------
//iPhone 6 OR 6S
func IS_IPHONE_6_OR_6S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 667
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}
//----------------------------------------------------------------
//iPhone 6Plus OR 6SPlus -
func IS_IPHONE_6P_OR_6SP()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 736
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}


//iPhone 6Plus OR 6SPlus -
func IS_IPHONE_x()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 812
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == UIScreen.main.bounds.size.height)    {
        device = true
    }
    return device
}

func IS_IPHONE_xR()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 896
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == UIScreen.main.bounds.size.height)    {
        device = true
    }
    return device
}


//----------------------------------------------------------------
//MARK:- DEVICE ORIENTATION CHECK -
func IS_DEVICE_PORTRAIT() -> Bool {
    return UIDevice.current.orientation.isPortrait
}
//----------------------------------------------------------------
func IS_DEVICE_LANDSCAPE() -> Bool {
    return UIDevice.current.orientation.isLandscape
}

//----------------------------------------------------------------
//MARK:- SYSTEM VERSION CHECK -
func SYSTEM_VERSION_EQUAL_TO(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                  options: NSString.CompareOptions.numeric) == ComparisonResult.orderedSame
}
//----------------------------------------------------------------
func SYSTEM_VERSION_GREATER_THAN(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                  options: NSString.CompareOptions.numeric) == ComparisonResult.orderedDescending
}
//----------------------------------------------------------------
func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                  options: NSString.CompareOptions.numeric) != ComparisonResult.orderedAscending
}
//----------------------------------------------------------------
func SYSTEM_VERSION_LESS_THAN(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                  options: NSString.CompareOptions.numeric) == ComparisonResult.orderedAscending
}
//----------------------------------------------------------------
func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version,
                                                  options: NSString.CompareOptions.numeric) != ComparisonResult.orderedDescending
}



