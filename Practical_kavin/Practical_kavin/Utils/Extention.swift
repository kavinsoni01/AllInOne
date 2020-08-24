//
//  Extention.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 22/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import Foundation
import UIKit
import CoreImage


extension UIColor {
        
    static let themeDarkGrayColor:UIColor = UIColor.init(red: 109/255.0, green: 112/255.0, blue: 114/255.0, alpha: 1.0)
    
    
       static let themeTextGrayColor:UIColor = UIColor.init(red: 109/255.0, green: 112/255.0, blue: 114/255.0, alpha: 1.0)
    

}




extension UIDevice {
    
    enum DeviceType: Int {
        case iPhone4or4s
        case iPhone5or5s
        case iPhone6or6s
        case iPhone6por6sp
        case iPhoneXorXs
        case iPhoneXrorXsMax
        case iPad
    }
    
    /// Check Decide type
    static var deviceType: DeviceType {
        // Need to match width also because if device is in portrait mode height will be different.
        if UIDevice.screenHeight == 480 || UIDevice.screenWidth == 480 {
            return DeviceType.iPhone4or4s
        } else if UIDevice.screenHeight == 568 || UIDevice.screenWidth == 568 {
            return DeviceType.iPhone5or5s
        } else if UIDevice.screenHeight == 667 || UIDevice.screenWidth == 667 {
            return DeviceType.iPhone6or6s
        } else if UIDevice.screenHeight == 736 || UIDevice.screenWidth == 736 {
            return DeviceType.iPhone6por6sp
        } else if UIDevice.screenHeight == 812 || UIDevice.screenWidth == 812 {
            return DeviceType.iPhoneXorXs
        } else if UIDevice.screenHeight == 896 || UIDevice.screenWidth == 896 {
            return DeviceType.iPhoneXorXs
        } else {
            return DeviceType.iPad
        }
    }
    
    /// Check device is Portrait mode
    static public var isPortrait: Bool {
        return UIDevice.current.orientation.isPortrait
    }
    
    /// Check device is Landscape mode
    static public var isLandscape: Bool {
        return UIDevice.current.orientation.isLandscape
    }
    
    // MARK: - Device Screen Height
    
    /// Return screen height
    static public var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    // MARK: - Device Screen Width
    
    /// Return screen width
    static public var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /// Return screen size
    static public var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    /// Return device model name
    public var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    // MARK: - Device is iPad
    /// Return is iPad device
    static public var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    // MARK: - Device is iPhone
    
    /// Return is iPhone device
    static public var isIphone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
extension String {
    
    
    func isValidPassword() -> Bool {
        let passwordRegex = "(^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d][\\w~@#$%^&*+=`|{}:;!.?\\\"()\\[\\]-]{6,}$)"
        
        
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self )
    }
    
    public var length: Int {
        return self.count
    }
    //----------------------------------------------------------------
    subscript(integerIndex: Int) -> Character {
        let index = self.index(self.startIndex, offsetBy: integerIndex)
        return self[index]
    }
    
 
    //----------------------------------------------------------------
    var getDateFromString: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self)
        return date!
    }
    var getDateFromStringK: Date {
        let dateFormatter = DateFormatter()
        //        2016-02-03 10:10:00
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self)
        return date!
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var convertToLocalDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"//ApplicationDateFormat.serverDateTimeFormat
        dateFormatter.timeZone = TimeZone.current
        if let dateFromString = dateFormatter.date(from: self) {
            return dateFromString
        }
        return Date()
    }
    
    //----------------------------------------------------------------
    func localized(using tableName: String?, in bundle: Bundle?) -> String {
        
        /* let bundle: Bundle = bundle ?? .main
         
         let currentLanguage = AILocalization.isCurrentLanguageBahasa ? AILanguage.bahasa.languageCodeToChangeLanguageInDefaults : AILanguage.english.languageCodeToChangeLanguageInDefaults
         
         if let path = bundle.path(forResource: currentLanguage, ofType: "lproj"), let bundle = Bundle(path: path) {
         return bundle.localizedString(forKey: self, value: nil, table: tableName)
         }
         else if let path = bundle.path(forResource: "Base", ofType: "lproj"),  let bundle = Bundle(path: path)   {
         return bundle.localizedString(forKey: self, value: nil, table: tableName)
         }
         return self*/
        return " "
    }
    //----------------------------------------------------------------
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
        //localized(using: nil, in: .main)
    }
    //----------------------------------------------------------------
    func isLastCharcterAWhiteSpace() -> Bool{
        
        if(self.length == 0){
            return false
        }
        
        var result:Bool = false
        if(self.length == 1){
            result = self[0] == " "
        } else{
            result = self[self.length-1] == " "
        }
        
        return result
    }
    //----------------------------------------------------------------
    func containsAdjacentSpaces() -> Bool{
        
        if(self.length == 0){
            return false
        }
        
        var result = false
        if(self.length == 1){
            result = false
        }else{
            var wasLastCharacterAWhiteSpace = false
            for i in 0..<self.length {
                let currentChar = self[i] as Character
                print(currentChar)
                if(currentChar == " "){
                    if(wasLastCharacterAWhiteSpace){
                        return true
                    }
                    wasLastCharacterAWhiteSpace = true
                }else{
                    wasLastCharacterAWhiteSpace = false
                }
            }
        }
        return result
    }
    //----------------------------------------------------------------
    func whiteSpaceTrimmed() -> String{
        return self.components(separatedBy: NSCharacterSet.whitespaces).filter({ !$0.isEmpty }).joined(separator: " ")
    }
    //----------------------------------------------------------------
    //    func encodedUrl() -> String{
    //        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    //    }
    //----------------------------------------------------------------
    func heightWithWidthAndFont(width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    //----------------------------------------------------------------
    func isValidEmail() -> Bool    {
        return ( (isValidEmail_OLD(stringToCheckForEmail: self as String))  && (isValidEmail_NEW(stringToCheckForEmail: self as String)) )
    }
    //----------------------------------------------------------------
    func isValidEmail_OLD(stringToCheckForEmail:String) -> Bool {
        let emailRegex = "[A-Z0-9a-z]+([._%+-]{1}[A-Z0-9a-z]+)*@[A-Z0-9a-z]+([.-]{1}[A-Z0-9a-z]+)*(\\.[A-Za-z]{2,4}){0,1}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: stringToCheckForEmail)
    }
    //----------------------------------------------------------------
    func isValidEmail_NEW(stringToCheckForEmail:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: stringToCheckForEmail)
    }
    
    //----------------------------------------------------------------
    var containsEmoji: Bool {
        get {
            for scalar in unicodeScalars {
                switch scalar.value {
                case 0x1F600...0x1F64F, // Emoticons
                0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                0x1F680...0x1F6FF, // Transport and Map
                0x2600...0x26FF,   // Misc symbols
                0x2700...0x27BF,   // Dingbats
                0xFE00...0xFE0F:   // Variation Selectors
                    return true
                default:
                    continue
                }
            }
            return false
        }
    }
    
    
}


    extension UIStoryboard {
        class func mainStoryBoard(name: String = "Main") -> UIStoryboard {
            return UIStoryboard(name: name, bundle: nil)
        }
    }


extension UIView{
    
    //Corner Round
    func setRoundCorner(radius : CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    func addDropShadow() -> Void {
         
         self.layer.masksToBounds = false;
         self.layer.shadowOffset = CGSize.init(width: 0, height: 0);
         self.layer.shadowRadius = 3;
         self.layer.shadowColor = UIColor.black.cgColor
         self.layer.shadowOpacity = 0.25;
     }
   
}




extension UIFont {
     /*
     Font Family Name: Avenir
        == Avenir-Regular
        == Avenir-Bold
     */
    

    class func appFont_RobotoBold(Size:CGFloat)->UIFont{
        
        if let font = UIFont.init(name: "Roboto-Bold", size: CGFloat(Size).proportionalFontSize()){
            return font
        } else {
            return UIFont (name: "HelveticaNeue-Bold", size: CGFloat(Size).proportionalFontSize())!
        }
    }
    
    class func appFont_RobotoRegular(Size:CGFloat)->UIFont{
        
        if let font = UIFont.init(name: "Roboto-Regular", size: CGFloat(Size).proportionalFontSize()){
            return font
        } else {
            return UIFont (name: "HelveticaNeue-Bold", size: CGFloat(Size).proportionalFontSize())!
        }
    }

    class func appFont_RobotoMedium(Size:CGFloat)->UIFont{
        
        if let font = UIFont.init(name: "Roboto-Medium", size:CGFloat(Size).proportionalFontSize()){
            return font
        } else {
            return UIFont (name: "HelveticaNeue-Bold", size: CGFloat(Size).proportionalFontSize())!
        }
    }
    
    //----------------------------------------------------------------
    class func appFont_RobotoLight(Size:CGFloat)->UIFont{
        
        if let font = UIFont.init(name: "roboto_regular", size: CGFloat(Size).proportionalFontSize()){
            return font
        } else {
            return UIFont (name: "HelveticaNeue-Bold", size: CGFloat(Size).proportionalFontSize())!
        }
    }
    
}



extension UIFont {
    var bold: UIFont { return withWeight(.bold) }
    var semibold: UIFont { return withWeight(.semibold) }
    
    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        
        traits[.weight] = weight
        
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName
        
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}


extension CGFloat{
    
    init?(_ str: String) {
        guard let float = Float(str) else { return nil }
        self = CGFloat(float)
    }

    
    func twoDigitValue() -> String {
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp //NumberFormatter.roundingMode.roundHalfUp
    
        
//        let str : NSString = formatter.stringFromNumber(NSNumber(self))!
        let str = formatter.string(from: NSNumber(value: Double(self)))
        return str! as String;
    }

    
    
    func proportionalFontSize() -> CGFloat {
        
        var sizeToCheckAgainst = self
        
        if(IS_IPAD_DEVICE())    {
//            sizeToCheckAgainst += 12
        }
        else {
            if(IS_IPHONE_6P_OR_6SP()) {
                sizeToCheckAgainst += 1
            }
            else if(IS_IPHONE_6_OR_6S()) {
                sizeToCheckAgainst += 0
            }
            else if(IS_IPHONE_5_OR_5S()) {
                sizeToCheckAgainst -= 1
            }
            else if(IS_IPHONE_4_OR_4S()) {
                sizeToCheckAgainst -= 2
            }else if(IS_IPHONE_x()){
                sizeToCheckAgainst += 1

            }else if(IS_IPHONE_xR()){
                sizeToCheckAgainst += 2
            }else{
                sizeToCheckAgainst += 2
            }
        }
        return sizeToCheckAgainst
    }
}


//MARK:- ALERT -
extension UIViewController{
    
func showAlertWithTitleFromVC(vc:UIViewController, andMessage message:String){
    
    showAlertWithTitleFromVC(vc: vc, title:"Practical", andMessage: message, buttons: ["Dismiss"]) { (index) in
    }
}
    
    // Common alertView
    func showAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }

//----------------------------------------------------------------

func showAlertWithTitleFromVC(vc:UIViewController, title:String, andMessage message:String, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void {
    
    
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for index in 0..<buttons.count    {
        
        let action = UIAlertAction(title: buttons[index], style: .default, handler: {
            (alert: UIAlertAction!) in
            if(completion != nil){
                completion(index)
            }
        })
        alertController.addAction(action)
    }
    vc.present(alertController, animated: true, completion: nil)
}


}

