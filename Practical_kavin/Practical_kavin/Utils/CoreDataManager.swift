//
//  CoreDataManager.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 23/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    static let shared:CoreDataManager = CoreDataManager()
    
    
    private override init() {
        
    }
    
    
    //Retrive All Details
    
   func retriveDataFromCoreData(_ complationHandler:@escaping(_ arrProduct:[Product]) -> ())  {
    var arrProduct:[Product] = []
       
       let managedContext =
         appDelegate.persistentContainer.viewContext
       
       let fetchRequest =
         NSFetchRequest<NSManagedObject>(entityName: Keys.entityProduct)
       
       
       do {
           let arr = try managedContext.fetch(fetchRequest) as! [Product]
           for objUser in arr{
             arrProduct.append(objUser)
           }
            complationHandler(arrProduct)
        
       } catch let error as NSError {
         print("Could not fetch. \(error), \(error.userInfo)")
       }
    
//       complationHandler(arrProduct)

   }
    
    
       
    func retriveSingleProductFromCoreData(_ oldProduct:Product, _ complationHandler:@escaping(_ product:Product) -> ())  {
        let context = appDelegate.persistentContainer.viewContext

              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.entityProduct)
        let predicateID = NSPredicate(format: "id == %@",NSNumber(value: oldProduct.id))
              
              fetchRequest.predicate = predicateID
               do {
              let results = try context.fetch(fetchRequest)
              let newProduct = results[0] as! NSManagedObject
           
                complationHandler(newProduct as! Product)
           } catch let error as NSError {
             print("Could not fetch. \(error), \(error.userInfo)")
           }
        
    //       complationHandler(arrProduct)

       }
    
    //Delete product
    
    func deleteProduct(_ model:Product , complationHandler:@escaping(_ isSuccess:Bool) -> ()){

        let context =
                  appDelegate.persistentContainer.viewContext

        // remove your object

        context.delete(model)

        // save your changes
        do {
                  try context.save()
                    complationHandler(true)
                   
                 } catch {
                  print("Failed saving")
            
            // success ...
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }        
        
    }
    
    
    //Is entity availabe check
    func isEntityExists(product: String) -> Bool {
             let context = appDelegate.persistentContainer.viewContext

             let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.entityProduct)
             let predicateID = NSPredicate(format: "name == %@",product)

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
    
    //MARK: Update Data Into Coredata

    
    func updateDataIntoCoredata(_ model:Product,productName:String,category:String,company:String,description:String ,qty:String,price:String ,image1:UIImage? ,image2:UIImage? ,image3:UIImage? ,image4:UIImage? , complationHandler:@escaping(_ isSuccess:Bool) -> ()){
        
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.entityProduct)
        let predicateID = NSPredicate(format: "id == %@",NSNumber(value: model.id))
        
        fetchRequest.predicate = predicateID
         do {
        let results = try context.fetch(fetchRequest)
        
        let newProduct = results[0] as! NSManagedObject
       
        newProduct.setValue(productName, forKey: Keys.name)
        newProduct.setValue(category, forKey: Keys.category)
        newProduct.setValue(company, forKey: Keys.company)
        if (image1 != nil){
            newProduct.setValue(image1!.pngData(), forKey: Keys.image1)
        }
        if (image2 != nil){
            newProduct.setValue(image2!.pngData(), forKey: Keys.image2)
        }
        if (image3 != nil){
            newProduct.setValue(image3!.pngData(), forKey: Keys.image3)
        }
        if (image4 != nil){
            newProduct.setValue(image4!.pngData(), forKey: Keys.image4)
        }
        newProduct.setValue(description, forKey: Keys.productdescription)
        newProduct.setValue(qty, forKey: Keys.qty)
        newProduct.setValue(price, forKey: Keys.price)

        do {
                  try context.save()
                    complationHandler(true)
                 } catch {
                  print("Failed saving")
            
            // success ...
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
         catch let error as NSError {
                   // failure
                   print("Fetch failed: \(error.localizedDescription)")
               }
    }
    //MARK: Store Data Into Coredata
          
    func addProductIntoCoredata(_ productName:String,category:String,company:String,description:String ,qty:String,price:String ,image1:UIImage? ,image2:UIImage? ,image3:UIImage? ,image4:UIImage? , complationHandler:@escaping(_ isSuccess:Bool) -> ()){
                                
              
              let context = appDelegate.persistentContainer.viewContext
              let entity = NSEntityDescription.entity(forEntityName: Keys.entityProduct, in: context)
                             
                  
                  if  self.isEntityExists(product: productName) == false{
                  
                  let newProduct = NSManagedObject(entity: entity!, insertInto: context)
                             
                  newProduct.setValue(productName, forKey: Keys.name)
                  newProduct.setValue(category, forKey: Keys.category)
                  newProduct.setValue(company, forKey: Keys.company)
                  if (image1 != nil){
                      newProduct.setValue(image1!.pngData(), forKey: Keys.image1)
                  }
                  if (image2 != nil){
                      newProduct.setValue(image2!.pngData(), forKey: Keys.image2)
                  }
                  if (image3 != nil){
                      newProduct.setValue(image3!.pngData(), forKey: Keys.image3)
                  }
                  if (image4 != nil){
                      newProduct.setValue(image4!.pngData(), forKey: Keys.image4)
                  }
                  newProduct.setValue(description, forKey: Keys.productdescription)
                  newProduct.setValue(qty, forKey: Keys.qty)
                  newProduct.setValue(price, forKey: Keys.price)
                    newProduct.setValue(findNextId(entityName: Keys.entityProduct), forKey: Keys.id)


                  do {
                            try context.save()
                            complationHandler(true)
                  } catch {
                            print("Failed saving")
                         }
                  
              }
                      
          }
    
    
    func findNextId(entityName:String) -> NSNumber {
          let context = appDelegate.persistentContainer.viewContext
                     let entity = NSEntityDescription.entity(forEntityName: Keys.entityProduct, in: context)
                     let req = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)

                     req.entity = entity
                        req.fetchLimit = 1
                        req.propertiesToFetch = [Keys.id]
                         let indexSort = NSSortDescriptor.init(key: Keys.id, ascending: false)
                        req.sortDescriptors = [indexSort]
                        do {
                            let fetchedData = try context.fetch(req)
                            if fetchedData.count > 0{
                            let firstObject = fetchedData.first as! NSManagedObject
                            if let foundValue = firstObject.value(forKey: Keys.id) as? NSNumber {
                             return NSNumber.init(value: foundValue.intValue + 1)
                            }
                            }else{
                                return NSNumber.init(value:1)
                            }
                         } catch {
                                    print(error)

                                }
                         return 0
          
      }
        
 
    
    //Add Category
    
    func addCategoryIntoCoredata(_ name:String , complationHandler:@escaping(_ isSuccess:Bool) -> ()){
                                   
                 
                 let context = appDelegate.persistentContainer.viewContext
                 let entity = NSEntityDescription.entity(forEntityName: Keys.entityCategory, in: context)
                                
                     if  self.isEntityExists(product: name) == false{
                     
                     let newCategory = NSManagedObject(entity: entity!, insertInto: context)
                     newCategory.setValue(name, forKey: Keys.name)
                     newCategory.setValue(findNextId(entityName: Keys.category), forKey: Keys.id)


                     do {
                               try context.save()
                               complationHandler(true)
                     } catch {
                               print("Failed saving")
                            }
                     
                 }
                         
             }
    
    //Delete Category
    func deleteCategory(_ model:Category , complationHandler:@escaping(_ isSuccess:Bool) -> ()){

          let context =
                    appDelegate.persistentContainer.viewContext

          // remove your object

          context.delete(model)

          // save your changes
          do {
                    try context.save()
                      complationHandler(true)
                     
                   } catch {
                    print("Failed saving")
              
              // success ...
          } catch let error as NSError {
              // failure
              print("Fetch failed: \(error.localizedDescription)")
          }
          
      }
      
    
    
    //Add Company
    func addComnapyIntoCoredata(_ name:String , complationHandler:@escaping(_ isSuccess:Bool) -> ()){
                                     
                   
                   let context = appDelegate.persistentContainer.viewContext
                   let entity = NSEntityDescription.entity(forEntityName: Keys.entityCompany, in: context)
                                  
                       if  self.isEntityExists(product: name) == false{
                       
                       let newCompany = NSManagedObject(entity: entity!, insertInto: context)
                       newCompany.setValue(name, forKey: Keys.name)
                       newCompany.setValue(findNextId(entityName: Keys.company), forKey: Keys.id)


                       do {
                                 try context.save()
                                 complationHandler(true)
                       } catch {
                                 print("Failed saving")
                              }
                       
                   }
                           
               }
    
    
    //Delete Company
    
    func deleteCompany(_ model:Company , complationHandler:@escaping(_ isSuccess:Bool) -> ()){

             let context =
                       appDelegate.persistentContainer.viewContext

             // remove your object

             context.delete(model)

             // save your changes
             do {
                       try context.save()
                         complationHandler(true)
                        
                      } catch {
                       print("Failed saving")
                 
                 // success ...
             } catch let error as NSError {
                 // failure
                 print("Fetch failed: \(error.localizedDescription)")
             }
             
         }
    
    
    //RETRIVE company data
       func retriveCompanyDataFromCoreData(_ complationHandler:@escaping(_ arrCompany:[Company]) -> ())  {
        var arrCompany:[Company] = []
           
           let managedContext =
             appDelegate.persistentContainer.viewContext
           
           let fetchRequest =
             NSFetchRequest<NSManagedObject>(entityName: Keys.entityCompany)
           
           
           do {
               let arr = try managedContext.fetch(fetchRequest) as! [Company]
               for objUser in arr{
                 arrCompany.append(objUser)
               }
                complationHandler(arrCompany)
            
           } catch let error as NSError {
             print("Could not fetch. \(error), \(error.userInfo)")
           }
        
    //       complationHandler(arrProduct)

       }
        
    
    
    // retrive category data
    
       func retriveCategoryDataFromCoreData(_ complationHandler:@escaping(_ arrCategory:[Category]) -> ())  {
        var arrCategory:[Category] = []
           
           let managedContext =
             appDelegate.persistentContainer.viewContext
           
           let fetchRequest =
             NSFetchRequest<NSManagedObject>(entityName: Keys.entityCategory)
           
           
           do {
               let arr = try managedContext.fetch(fetchRequest) as! [Category]
               for objUser in arr{
                 arrCategory.append(objUser)
               }
                complationHandler(arrCategory)
            
           } catch let error as NSError {
             print("Could not fetch. \(error), \(error.userInfo)")
           }
        
    //       complationHandler(arrProduct)

       }
        
    
}
