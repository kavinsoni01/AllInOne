//
//  HomeTableCell.swift
//  Techtic_practical
//
//  Created by Kavin Soni on 24/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit
import SDWebImage

class HomeTableCell: UITableViewCell {
   
    //MARK: Variable
    
    var buttonType:ButtonType = .notDownload
    
    //MARK: Outlets
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var imgMusic: UIImageView!
    @IBOutlet weak var lblCollectionName: UILabel!
    @IBOutlet weak var lblTrackName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.async {
            self.viewBack.layer.cornerRadius = 5
            self.viewBack.clipsToBounds = true
            self.viewBack.addDropShadow()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(track:Track) -> Void {
        self.lblTrackName.text = track.trackname
        self.lblCollectionName.text = track.albumname
        self.setupDownloadButton(buttonStatus: Int(track.status))
        if (track.trackimage != nil) {
            self.imgMusic.image = UIImage.init(data: track.trackimage!)
        }else if (track.imageurl != nil) {
            self.imgMusic.sd_setImage(with: URL(string: track.imageurl!), placeholderImage: UIImage(named: "music"))
        }
    }
    
    
    func setupDownloadButton(buttonStatus:Int) -> Void {
            if buttonStatus == 0{
                  self.buttonType = .notDownload
                  self.btnDownload.setImage(UIImage.init(named:"download"), for: .normal)
              }else if buttonStatus == 1{
                  self.buttonType = .downloaded
                  self.btnDownload.setImage(UIImage.init(named:"play"), for: .normal)
              }
//            else if buttonStatus == 2{
//                  self.buttonType = .playing
//                  self.btnDownload.setImage(UIImage.init(named:"stop"), for: .normal)
//              }
    }
    @IBAction func btnDownload(_ sender: Any) {
        switch buttonType {
        case .notDownload:
            break
        case .downloaded:
            break
        case .playing:
            break
        }
    }
    
}
