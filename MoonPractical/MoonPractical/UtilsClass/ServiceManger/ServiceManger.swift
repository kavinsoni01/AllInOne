//
//  ServiceManger.swift
//  MoonPractical
//
//  Created by Kavin Soni on 21/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit
import Alamofire


typealias Response<T> = (_ result: AFDataResponse<T>) -> Void

enum ApiType:Int{
    case getUser
    
    func getURL() -> String {
        switch self {
        case .getUser:
            return "public/api/user"
        @unknown default:
            return ""
        }
    }

}
class ServiceManger: NSObject {
        
    var baseURL = "https://beta3.moontechnolabs.com/app_practical_api/"
    static let shared:ServiceManger = ServiceManger()
    
    private override init() {
        
    }
 
    
    //MARK Call get API
    func callGetApi(_ type:ApiType , complationHandler:@escaping(_ data:[String:Any]) -> ()){
    
//    func callGetApi(_ type:ApiType){
        let getURL =  baseURL + type.getURL()
        
        print(getURL)
        AF.request(getURL,
        method: .get,
        encoding: URLEncoding.httpBody,
        headers: [:]).responseJSON { [unowned self] (dataResonse) in
            print(dataResonse)
            switch (dataResonse).result {
                       case .success(let value as [String: Any]):
                           complationHandler(value)

            case .failure(let error): break
                       // complationHandler(error.errorDescription)

                       default:
                           fatalError("received non-dictionary JSON response")
                       }
            
        }
                
    }
}
