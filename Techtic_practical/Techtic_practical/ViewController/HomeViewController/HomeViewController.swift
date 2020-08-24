//
//  HomeViewController.swift
//  Techtic_practical
//
//  Created by Kavin Soni on 24/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

enum ButtonType:Int{
    case notDownload
    case downloaded
    case playing
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    //Variables
    private var arrTrack:[Track] = []
    private var audioPlayer: AVPlayer?

    //Outlets
    @IBOutlet weak var tblTrackList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()

    }
    
//MARK:setup UI
    func setupUI() -> Void {
        
        self.tblTrackList.delegate = self
        self.tblTrackList.dataSource = self
        self.tblTrackList.separatorStyle = .none
        self.tblTrackList.register(UINib.init(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        
        self.getAllTrackAPI()
    }
    
//MARK: Tableview Datasource and delegate methods
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return arrTrack.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
         let cell:HomeTableCell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell") as! HomeTableCell
         cell.selectionStyle = .none
         cell.setupCell(track: arrTrack[indexPath.row])
         cell.btnDownload.tag = indexPath.row
         cell.btnDownload.addTarget(self, action: #selector(self.buttonDownloadClicked(_:)), for: .touchUpInside)
        
         return cell
       }
       
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 75
     }
    
    
    //MARK: Button clicked - download- play/pause
    @objc func buttonDownloadClicked(_ sender:UIButton) -> Void {
        let currentModel = arrTrack[sender.tag]
        let index = IndexPath.init(row: sender.tag, section: 0)

        if currentModel.status == 0 {
            self.downloadTrack(task: currentModel , index: index) { [unowned self](isSuccess) in
                let cell =  self.tblTrackList.cellForRow(at: index) as! HomeTableCell
                cell.btnDownload.setImage(UIImage.init(named:"stop"), for: .normal)
              //  self.tblTrackList.reloadRows(at: [index], with: .automatic)
                
            }
        }else if currentModel.status == 1 {
            
            print(currentModel.documentLink!)
            self.playMusic(url: currentModel.documentLink!, index: index)
        }
    }
    //MARK: Download task
    
    func downloadTrack(task:Track , index:IndexPath , completion: @escaping ((_ isSuccess: Bool)->Void)) {
                             
        let name = removeSpecialCharsFromString(text: task.trackname!)
        let newString = name.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                           
        let path = "\(newString)" + ".m4a"
        checkFileExists(withLink: path , track: task) { [unowned self] (url) in
            CoreDataManager.shared.updateStatusTrackIntoCoredata(task, status: 1, documentLink: url) { [unowned self](isSuccess) in
               
                self.playMusic(url:url, index: index)

            }
            
            completion(true)

        }
       
    }
    //MARK: Check file is available or not
    func checkFileExists(withLink link: String , track:Track, completion: @escaping ((_ filePath: URL)->Void)){
        
       
//         let fileURL: URL = folderPath.appendingPathComponent(pathComponent)
        
        
        let urlString = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        if let url  = URL.init(string: urlString ?? ""){
            let fileManager = FileManager.default
            
            if let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create: false){

                let filePath = documentDirectory.appendingPathComponent(url.lastPathComponent, isDirectory: false)
            
                do {
                    if try filePath.checkResourceIsReachable() {
                        print("file exist")
                        completion(filePath)

                    } else {
                        print("file doesnt exist")
                        if AIReachabilityManager.shared.isInternetAvailableForAllNetworks() {

                        downloadFile(withUrl: URL.init(string:track.audioLink!)!, andFilePath: filePath, completion: completion)
                        }else{
                            let alert = UIAlertController(title: "Practical", message: "Please check internet connection.", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)

                        }
                    }
                } catch {
                    print("file doesnt exist")

//                    print(url)
                    if AIReachabilityManager.shared.isInternetAvailableForAllNetworks() {

                    downloadFile(withUrl: URL.init(string:track.audioLink!)!, andFilePath: filePath, completion: completion)
                    }else{
                        let alert = UIAlertController(title: "Practical", message: "Please check internet connection.", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)

                                           }
                }
            }else{
                 print("file doesnt exist")
            }
        }else{
                print("file doesnt exist")
        }
    }
    
    
//    func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: URL)->Void)){
//        DispatchQueue.global(qos: .background).async {
//            do {
//                let data = try Data.init(contentsOf: url)
//                try data.write(to: filePath, options: .atomicWrite)
//                print("saved at \(filePath.absoluteString)")
//                DispatchQueue.main.async {
//                    completion(filePath)
//                }
//            } catch {
//                print("an error happened while downloading or saving the file")
//            }
//        }
//    }
//
    
    func playMusic(url:URL , index:IndexPath) -> Void {
        
        

        
        let cell:HomeTableCell = (self.tblTrackList.cellForRow(at: index) as! HomeTableCell)
            
            if cell.btnDownload.imageView?.image == UIImage.init(named: "stop"){
                audioPlayer?.pause()
                cell.btnDownload.setImage(UIImage.init(named: "play"), for: .normal)
            }else{
        
                cell.btnDownload.setImage(UIImage.init(named: "stop"), for: .normal)
                
                       let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                       
                
                       // lets create your destination file url
                       let destinationUrl = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)

                print(destinationUrl)
                
                let url = destinationUrl//URL.init(string: destinationUrl)
                      do {
                          audioPlayer = AVPlayer(url: url)
                        guard let player = audioPlayer else { return }

                        player.play()
                        
                      } catch let error {
                          print(error.localizedDescription)
                      }
                
                
               

            }

             
    }
    
    //MARK: Download Music file
    
    func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: URL)->Void)){
               
               // then lets create your document folder url
               let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
               
        
               // lets create your destination file url
               let destinationUrl = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
               print(destinationUrl)
               
               // to check if it exists before downloading it
               if FileManager.default.fileExists(atPath: destinationUrl.path) {
                   print("The file already exists at path")
                   DispatchQueue.main.async {
                                                              completion(destinationUrl)
                                          }
                   // if the file doesn't exist
               } else {
                   
                   // you can use NSURLSession.sharedSession to download the data asynchronously
                   URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                       guard let location = location, error == nil else { return }
                       do {
                           // after downloading your file you need to move it to your destination url
                           try FileManager.default.moveItem(at: location, to: destinationUrl)
                           print("File moved to documents folder")
                          DispatchQueue.main.async {
                                            completion(destinationUrl)
                        }
                            
                       } catch let error as NSError {
                           print(error.localizedDescription)
                       }
                   }).resume()
               }
           
           
       }
    
    
    //MARK: Call API
    
    func getAllTrackAPI() -> Void {
        
        if AIReachabilityManager.shared.isInternetAvailableForAllNetworks() {
             ServiceManger.shared.callGetApi(ApiType.getUser) { [unowned self](dict) in
                    //    print(dict)
                
                if let results = dict["results"] as? [NSDictionary]{
                    self.arrTrack = []
                    for obj in results{
                        let trackModel = TrackModel.init(dic: obj as! [String : Any])
                        CoreDataManager.shared.addTrackIntoCoredata(trackModel)
                    }
                    self.updateImages()
                    self.retriveAllTracks()
                }
            }

        }else{
            self.retriveAllTracks()

        }
    }
    //MARK: Update image in coredata
    func updateImages() -> Void {
        
        for obj in arrTrack{
            
            AF.request(obj.imageurl!,method: .get).response{  response in
            //
                                      switch response.result {
                                      case .success(let responseData):
                                        CoreDataManager.shared.updateImageTrackIntoCoredata(obj, imageData: responseData!)
                                                                                
                                        break
                                        case .failure(let error):
                                        print("error--->",error)
                }
            }
        }
    }
    //MARK: Retrive all Tracks
    func retriveAllTracks() -> Void {
        
        CoreDataManager.shared.retriveTrackFromCoreData { [unowned self](tracks) in
                
                DispatchQueue.main.async {
                    self.arrTrack = tracks
                    self.tblTrackList.reloadData()
                }
        }
       

    }
    
    //Remove special character
     func removeSpecialCharsFromString(text: String) -> String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
          return text.filter {okayChars.contains($0) }
        
     }

}
