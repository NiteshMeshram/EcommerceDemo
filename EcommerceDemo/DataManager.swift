//
//  DataManager.swift
//  EcommerceDemo
//
//  Created by Nitesh Meshram on 3/12/18.
//  Copyright © 2018 NItesh. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    static let sharedInstance = DataManager()
    
    private func createCategoryEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        /** Products Category Parsing Start **/
        let predicate = NSPredicate(format: "categoryId = %@",((dictionary["id"] as? Int64)?.description)!)
        if !(checkDataExistOrNot(predicate: predicate, entityName: "ProductlCategory")) {
            
            if let categoryEntity = NSEntityDescription.insertNewObject(forEntityName: "ProductlCategory", into: context) as? ProductlCategory {
                categoryEntity.categoryId = (dictionary["id"] as? Int64)?.description
                categoryEntity.catagoryName = dictionary["name"] as? String
                
                do {
                    try categoryEntity.managedObjectContext?.save()
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
                
                /** products  Parsing Start **/
                if let productsArray = dictionary["products"] as? [[String: Any]] {
                    _ = productsArray.map{
                        if let prod = self.createProductEntityFrom(dictionary: $0 as [String : AnyObject]) as? ProductList {
                            
                            prod.categoryDetails = categoryEntity
                            categoryEntity.addToProductDetails(prod)
                            
                            
                            
                        }
                    }
                }
                /** products  Parsing End **/
                
                
                /** child_categories  Parsing Start **/
                
                if let subCategoryArray = dictionary["child_categories"] as? [[String: Any]] {
                    _ = subCategoryArray.map{
                        if let subCategory = self.createChildCategoryEntityFrom(dictionary: $0 as [String : AnyObject]) as? ChildCategory {
                            categoryEntity.addToChildCategoryDetails(subCategory)
                        }
                    }
                }
                
                /** child_categories  Parsing End **/
                
                /** Products Category Parsing End **/
                return categoryEntity
            }
            
        }
        return nil
    }
    
    private func createProductEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        let predicate = NSPredicate(format: "productId = %@",((dictionary["id"] as? Int64)?.description)!)
        if !(checkDataExistOrNot(predicate: predicate, entityName: "ProductList")) {
            
            if let productListEntity = NSEntityDescription.insertNewObject(forEntityName: "ProductList", into: context) as? ProductList {
                productListEntity.productId = (dictionary["id"] as? Int64)?.description
                productListEntity.productName = dictionary["name"] as? String
                productListEntity.productAddedDate = dictionary["date_added"] as? String
                productListEntity.tax = dictionary["tax"]!["name"] as? String
                productListEntity.vat = dictionary["tax"]!["value"] as? String //(dictionary["tax"]!["value"] as? Int64)?.description
                
                
                if let variantsArray = dictionary["variants"] as? [[String: Any]] {
                    _ = variantsArray.map{
                        if let variant = self.createVariantEntityFrom(dictionary: $0 as [String : AnyObject]) as? VariantsList {
                            
                            productListEntity.addToVariantsDetails(variant)
                            
                        }
                    }
                }
                
                
                do {
                    try productListEntity.managedObjectContext?.save()
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
                
                return productListEntity
            }
            
        }
        
        return nil
    }
    private func createVariantEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        let predicate = NSPredicate(format: "variantId = %@",((dictionary["id"] as? Int64)?.description)!)
        if !(checkDataExistOrNot(predicate: predicate, entityName: "VariantsList")) {
            
            if let variantListEntity = NSEntityDescription.insertNewObject(forEntityName: "VariantsList", into: context) as? VariantsList {
                variantListEntity.variantId = (dictionary["id"] as? Int64)?.description
                variantListEntity.variantColor = dictionary["color"] as? String
                variantListEntity.variantSize = (dictionary["size"] as? Int64)?.description
                variantListEntity.variantPrice = (dictionary["price"] as? Int64)?.description 
                
                do {
                    try variantListEntity.managedObjectContext?.save()
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
                
                return variantListEntity
            }
            
        }
        
        return nil
        
    }
    
    private func createRankingEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if let productsArray = dictionary["products"] as? [[String: Any]] { // Start Product Array
            
            _ = productsArray.map{ // Start of Map
                
                if let (prod, rankingCount) = self.fetchProduct(dictionary: $0 as [String : AnyObject]) as? (ProductList, String ) {
                    
                    let predicate = NSPredicate(format: "rankingName = %@ AND rankingTypeCount = %@ ",(dictionary["ranking"] as? String)!,rankingCount)
                    
                    if !(checkDataExistOrNot(predicate: predicate, entityName: "Rankings")) {
                        
                        if let rankingsEntity = NSEntityDescription.insertNewObject(forEntityName: "Rankings", into: context) as? Rankings {
                            
                            rankingsEntity.rankingName = dictionary["ranking"] as? String
                            rankingsEntity.rankingTypeCount = rankingCount
                            prod.addToRankingDetails(rankingsEntity)
                            
                            do {
                                try rankingsEntity.managedObjectContext?.save()
                                
                            } catch {
                                let saveError = error as NSError
                                print(saveError)
                            }
                            
                        }
                    }
                }
            } // End of Map
        } // End Product Array
        return nil
        
    }
    
    private func createChildCategoryEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        let predicate = NSPredicate(format: "subCategoryId = %@",((dictionary["id"] as? Int64)?.description)!)
        if !(checkDataExistOrNot(predicate: predicate, entityName: "ChildCategory")) {
            
            if let childCategoryEntity = NSEntityDescription.insertNewObject(forEntityName: "ChildCategory", into: context) as? ChildCategory {
                childCategoryEntity.subCategoryId = (dictionary["id"] as? Int64)?.description
                
                
                do {
                    try childCategoryEntity.managedObjectContext?.save()
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
                
                return childCategoryEntity
            }
            
        }
        
        return nil
        
    }
    
    
    private func checkDataExistOrNot(predicate: NSPredicate, entityName: String) -> Bool {
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: CoreDataStack.sharedInstance.persistentContainer.viewContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = predicate
        
        do {
            let result = try CoreDataStack.sharedInstance.persistentContainer.viewContext.execute(fetchRequest)
            //            print(result)
            return false
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return true
        }
        return true
    }
    
    private func saveProductInCoreDataWith(array: [[String: AnyObject]]) {
        
        _ = array.map{self.createProductEntityFrom(dictionary: $0)}
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    // Public methods 
    
    func saveCategoryInCoreDataWith(array: [[String: AnyObject]], completion: (Bool) -> ()) {
        _ = array.map{self.createCategoryEntityFrom(dictionary: $0)}
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
            completion(true)
        } catch let error {
            print(error)
        }
    }
    
    func saveRankingInCoreDataWith(array: [[String: AnyObject]]) {
        //        print(array)
        _ = array.map{self.createRankingEntityFrom(dictionary: $0)}
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    
    
    
    
    
    func fetchAllProducts()  -> [ProductList] {
        //(entityName: String) -> [ProductList] {
        
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductList")
        
        do {
            let results = try context.fetch(fetchRequest)
            let  allProducts = results as! [ProductList]
            
            //            print("\(allProducts)")
            return allProducts
            
        }catch let err as NSError {
            print(err.debugDescription)
            return []
        }
        
        return []
    }
    
    func fetchAllCategories()-> [ProductlCategory]{
        //(entityName: String) -> [ProductlCategory] {
        
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductlCategory")
        
        do {
            let results = try context.fetch(fetchRequest)
            let  allCategories = results as! [ProductlCategory]
            
            //            print("\(allProducts)")
            return allCategories
            
        }catch let err as NSError {
            print(err.debugDescription)
            return []
        }
        
        return []
    }
    
    ///
    
    
    func fetchAllRainking()-> [Rankings]{
        //(entityName: String) -> [ProductlCategory] {
        
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rankings")
        
        do {
            let results = try context.fetch(fetchRequest)
            let  allRankings = results as! [Rankings]
            
            //            print("\(allProducts)")
            return allRankings
            
        }catch let err as NSError {
            print(err.debugDescription)
            return []
        }
        
        return []
    }
    
    
    
    
    
    ///
    // (String, Int)
    func fetchProduct(dictionary: [String: AnyObject]) -> (ProductList, String) {
        
        var product:ProductList = ProductList()
        var rankingTypeCount: String = ""
        
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult> (entityName: "ProductList")
        
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        let predicate = NSPredicate(format: "productId = %@",((dictionary["id"] as? Int64)?.description)!)
        
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            let  products = results as! [ProductList]
            product = products[0]
            
            if let viewCount = dictionary["view_count"] {
                rankingTypeCount = String(describing: viewCount)
                
            }
            
            if let orderCount = dictionary["order_count"]  {
                rankingTypeCount = String(describing: orderCount)
            }
            
            if let shares = dictionary["shares"] {
                rankingTypeCount = String(describing: shares)
                
                
            }
            
            
            return (product, rankingTypeCount)
            //            return product
            
        }catch let err as NSError {
            print(err.debugDescription)
            //            return product
            return (product, rankingTypeCount)
        }
        
        //        return product
        return (product, rankingTypeCount)
    }
    
    func aggregateProductsInContext() -> [[String:AnyObject]]? {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        // Create an array of AnyObject since it needs to contain multiple types--strings and
        // NSExpressionDescriptions
        var expressionDescriptions = [AnyObject]()
        
        // We want productLine to be one of the columns returned, so just add it as a string
        expressionDescriptions.append("rankingName" as AnyObject)
        
        // Build out our fetch request the usual way
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Rankings")
        // This is the column we are grouping by. Notice this is the only non aggregate column.
        request.propertiesToGroupBy = ["rankingName"]
        // Specify we want dictionaries to be returned
        request.resultType = .dictionaryResultType
        // Go ahead and specify a sorter
        request.sortDescriptors = [NSSortDescriptor(key: "rankingName", ascending: true)]
        // Hand off our expression descriptions to the propertiesToFetch field. Expressed as strings
        
        request.propertiesToFetch = expressionDescriptions
        
        // Our result is going to be an array of dictionaries.
        var results:[[String:AnyObject]]?
        
        // Perform the fetch. This is using Swfit 2, so we need a do/try/catch
        do {
            results = try context.fetch(request) as? [[String:AnyObject]]
        } catch _ {
            // If it fails, ensure the array is nil
            results = nil
        }
        
        return results
    }
    
    func productsWith(rankingName:String) -> () {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Rankings")
        request.predicate = NSPredicate(format: "rankingName = %@", rankingName)
//        request.sortDescriptors = [NSSortDescriptor(key: "productName", ascending: true)]
        
//        var results:[Product]?
        
        do {
           let results = try context.fetch(request)// as? [Product]
            print(results)
        } catch let err as NSError {
            print(err.debugDescription)
            //return []
        }
        
//        return results
    }
    
    /*
     
     let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
     let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductList")
     
     do {
     let results = try context.fetch(fetchRequest)
     let  allProducts = results as! [ProductList]
     
     //            print("\(allProducts)")
     return allProducts
     
     }catch let err as NSError {
     print(err.debugDescription)
     return []
     }
     
     return []
     
     */
    
}


