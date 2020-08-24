//
//  extention.swift
//  MoonPractical
//
//  Created by Kavin Soni on 21/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import Foundation


extension Date {
func app_stringFromDate(dateFormate: String) -> String {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormate
    return dateFormatter.string(from: self)
}
    
}


