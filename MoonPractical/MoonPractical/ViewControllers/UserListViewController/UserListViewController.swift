//
//  UserListViewController.swift
//  MoonPractical
//
//  Created by Kavin Soni on 21/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit
import CoreData

class UserListViewController: UIViewController,UISearchControllerDelegate, UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate{
  
    //VARIABLE
    
    var arrUsers:[UserModel] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var filtered = false
    var arrFiltered:[UserModel] = []
    var searchBarValue:String = ""
    var searchActive : Bool = false
    var refreshControl = UIRefreshControl()

    
    
    //OUTLETS
    @IBOutlet weak var tblUserList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
        self.title = "Employee"
        
        
        //get data from Coredata
        retriveDataFromCoreData()
        
        
        if self.arrUsers.count > 0 {
            
        }else{
            //Call api

            self.callUserListAPI()

        }
        
    }
    

    
    //MARK: Setup UI
    
    func setupUI() -> Void {
        
        tblUserList.delegate = self
        tblUserList.dataSource = self
        tblUserList.separatorStyle = .none
        
        tblUserList.register(UINib.init(nibName: "UserTableCell", bundle: nil), forCellReuseIdentifier:"UserTableCell")
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor:UIColor.black,
             NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 22)]
        
        
//        //Search bar code
          let searchController: UISearchController = {
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchBar.placeholder = "Search"
            searchController.searchBar.searchBarStyle = .minimal
//            searchController.dimsBackgroundDuringPresentation = false
            searchController.definesPresentationContext = true

           return searchController
        }()
        
        searchController.searchBar.delegate = self
        searchController.delegate = self
//        let search = UISearchController(searchResultsController: nil)
//              search.searchResultsUpdater = self
              self.navigationItem.searchController = searchController
        
        
        //Pull to refresh code
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblUserList.addSubview(refreshControl)
        
        
    }
    
    //MARK: Search bar Methods
    

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBarValue = ""
        DispatchQueue.main.async {
                           self.tblUserList.reloadData()
                       }    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
  

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        arrFiltered = arrUsers.filter({$0.full_name.contains(searchText)})
        

//        if (arrFiltered.count == 0){
//            print(arrFiltered.count)
//            searchActive = false
//        }
//        else{
//            searchActive = true
//        }
        DispatchQueue.main.async {
                           self.tblUserList.reloadData()
    }
    }
    
    
    
    //MARK: Pull to refresh
    

    @objc func refresh(_ sender: AnyObject) {
        self.callUserListAPI()
    }
    
    
    
    
    //MARK: Tableview Datasource and delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive == true{
            return arrFiltered.count
        }
        return arrUsers.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
        let cell:UserTableCell = tableView.dequeueReusableCell(withIdentifier: "UserTableCell") as! UserTableCell
        cell.selectionStyle = .none
        if searchActive == true{
            if arrFiltered.count > 0 {
                cell.setData(obj: arrFiltered[indexPath.row])
            }
        }else{
             if arrUsers.count > 0 {
            cell.setData(obj: arrUsers[indexPath.row])
            }

        }
        return cell
      }
      
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailScreen:UserDetailViewController = self.storyboard?.instantiateViewController(withIdentifier:"UserDetailViewController") as! UserDetailViewController
        if searchActive == true {
            detailScreen.objUser = arrFiltered[indexPath.row]

        }else{
            detailScreen.objUser = arrUsers[indexPath.row]

        }
        self.navigationController?.pushViewController(detailScreen, animated: true)
    }
    
    //MARK: Store Data Into Coredata
    
    func addUserIntoCoredata(userModel:UserModel) -> Void {
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: Keys.entityname, in: context)
        
        if isEntityExists(id: userModel.id) == true{
            
        }else{
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
                       
                   newUser.setValue(userModel.full_name, forKey: Keys.full_name)
                   newUser.setValue(userModel.address, forKey: Keys.address)
                   newUser.setValue(userModel.email, forKey: Keys.email)
                   newUser.setValue(userModel.created_at, forKey: Keys.created_at)
                   newUser.setValue(userModel.designation, forKey: Keys.designation)
                   newUser.setValue(userModel.gender, forKey: Keys.gender)
                   newUser.setValue(userModel.id, forKey: Keys.id)
                   newUser.setValue(userModel.phone, forKey: Keys.phone)
                   newUser.setValue(userModel.profilePicUrl, forKey: Keys.profile_pic_url)
                   newUser.setValue(userModel.salary, forKey: Keys.salary)
                   newUser.setValue(userModel.updated_at, forKey: Keys.updated_at)
            newUser.setValue(userModel.dob, forKey: Keys.dob)

                   do {
                      try context.save()
                     } catch {
                      print("Failed saving")
                   }
            
        }
       
                
    }
    
    
    func isEntityExists(id: Int) -> Bool {
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.entityname)
        let predicateID = NSPredicate(format: "id == %@",NSNumber.init(integerLiteral: id))

        fetchRequest.predicate = predicateID

//        fetchRequest.includesSubentities = false

        var entitiesCount = 0

        do {
            entitiesCount = try context.count(for: fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }

        return entitiesCount > 0
    }
    
    
    
    func retriveDataFromCoreData()  {
    
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Keys.entityname)
        
        
        do {
            let arrUsers = try managedContext.fetch(fetchRequest) as! [User]
            self.arrUsers = []
            for objUser in arrUsers{
                self.arrUsers.append(UserModel.init(coredataDict: objUser))
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
    }
    //MARK: CALL API
    
    
    func callUserListAPI() -> Void {
        
        ServiceManger.shared.callGetApi(ApiType.getUser) { [unowned self] (response) in
            print(response)
            self.arrUsers = []
            if let arrTemp = response["data"] as? [Any]{
                for objUser in arrTemp{
                    let userModel = UserModel.init(dic: objUser as! [String : Any])
                        
                    self.addUserIntoCoredata(userModel: userModel)
                    self.arrUsers.append(userModel)
                }
                self.refreshControl.endRefreshing()

                DispatchQueue.main.async {
                    self.tblUserList.reloadData()
                }
            }
        }
    }
}
