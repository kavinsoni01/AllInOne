//
//  CoreDataManager.swift
//  Techtic_practical
//
//  Created by Kavin Soni on 24/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

class CoreDataManager: NSObject {
    static let shared:CoreDataManager = CoreDataManager()
    
    
    private override init() {
        
    }
    
    
    //MARK: Store Data Into Coredata
             
    func addTrackIntoCoredata(_ model:TrackModel){ //, complationHandler:@escaping(_ isSuccess:Bool) -> ()){
                                   
                 
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: Keys.entityTrack, in: context)
                                
        
    if  self.isEntityExists(model:model) == false{
                   
        let newTrack = NSManagedObject(entity: entity!, insertInto: context)
        newTrack.setValue(model.collectionName, forKey: Keys.albumname)
        newTrack.setValue(model.trackName, forKey: Keys.trackname)
        newTrack.setValue(model.trackId, forKey: Keys.id)
        newTrack.setValue(model.imageURL, forKey: Keys.imageurl)
        newTrack.setValue(model.audioLink, forKey: Keys.audioLink)

                     do {
                               try context.save()
//                               complationHandler(true)
                     } catch {
                               print("Failed saving")
                            }
                     
                 }
                         
             }

    
    
    func updateStatusTrackIntoCoredata(_ model:Track , status:Int, documentLink:URL , _ complationHandler:@escaping(_ isSuccess:Bool) -> ()){
                            
    //
                                        let context = appDelegate.persistentContainer.viewContext

                                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.entityTrack)

                                        let predicateID = NSPredicate(format: "id == %@",NSNumber(value: model.id))
                                        fetchRequest.predicate = predicateID
            
                            do {
                                        let results = try context.fetch(fetchRequest)
                                        let newTrack = results[0] as! NSManagedObject
                                        newTrack.setValue(status, forKey: Keys.status)
                                        newTrack.setValue(documentLink, forKey: Keys.documentLink)

                            do {
                                try context.save()
                                complationHandler(true)
                                } catch {
                                        print("Failed saving")
                                }
                           }    catch {
                                   print("Failed saving")
                           }
                     }
    
    
    func updateImageTrackIntoCoredata(_ model:Track , imageData:Data ){ //, complationHandler:@escaping(_ isSuccess:Bool) -> ()){
                        
//
                                    let context = appDelegate.persistentContainer.viewContext

                                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.entityTrack)

                                    let predicateID = NSPredicate(format: "id == %@",NSNumber(value: model.id))
                                    fetchRequest.predicate = predicateID
        
                        do {
                                    let results = try context.fetch(fetchRequest)
                                    let newTrack = results[0] as! NSManagedObject
                                    newTrack.setValue(imageData, forKey: Keys.trackimage)
                        do {
                            try context.save()
                                         //                               complationHandler(true)
                            } catch {
                                    print("Failed saving")
                            }
                       }    catch {
                               print("Failed saving")
                       }
                 }
    
    //Is entity availabe check
    func isEntityExists(model: TrackModel) -> Bool {
             let context = appDelegate.persistentContainer.viewContext

             let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.entityTrack)
        let predicateID = NSPredicate(format: "id == %@",NSNumber.init(value: model.trackId))

             fetchRequest.predicate = predicateID

             var entitiesCount = 0

             do {
                 entitiesCount = try context.count(for: fetchRequest)
             }
             catch {
                 print("error executing fetch request: \(error)")
             }

             return entitiesCount > 0
         }
    
    
        
        //RETRIVE company data
           func retriveTrackFromCoreData(_ complationHandler:@escaping(_ arrTrack:[Track]) -> ())  {
            var arrTracks:[Track] = []
               
               let managedContext =
                 appDelegate.persistentContainer.viewContext
               
               let fetchRequest =
                 NSFetchRequest<NSManagedObject>(entityName: Keys.entityTrack)
               
               do {
                   let tracks = try managedContext.fetch(fetchRequest) as! [Track]
                   
                    for objUser in tracks{
                     arrTracks.append(objUser)
                   }
                    complationHandler(arrTracks)
                
               } catch let error as NSError {
                 print("Could not fetch. \(error), \(error.userInfo)")
               }
            
        //       complationHandler(arrProduct)

           }
            
        
        
    }

