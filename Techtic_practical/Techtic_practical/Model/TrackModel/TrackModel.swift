//
//  TrackModel.swift
//  Techtic_practical
//
//  Created by Kavin Soni on 24/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit

class TrackModel: NSObject {


    var artistId:Int = 0
    var trackId:Int = 0
    var artistName:String = ""
    var imageURL:String = ""
    var collectionName:String = ""
    var trackName:String = ""

    var audioLink:String = ""

    init(dic:[String:Any]) {
         if let value = dic["artistId"] as? Int{
                self.artistId = value
         }
        if let value = dic["artistName"] as? String{
                self.artistName = value
        }
        
        if let value = dic["previewUrl"] as? String{
                self.audioLink = value
        }
        
        if let value = dic["artworkUrl100"] as? String{
                self.imageURL = value
        }
        
        if let value = dic["collectionName"] as? String{
                self.collectionName = value
        }
        
        if let value = dic["collectionName"] as? String{
                self.collectionName = value
        }
        
        if let value = dic["trackId"] as? Int{
                self.trackId = value
        }
        
        if let value = dic["trackName"] as? String{
                self.trackName = value
        }
      
         
    }
}
