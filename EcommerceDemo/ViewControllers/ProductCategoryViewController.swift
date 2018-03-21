//
//  ProductCategoryViewController.swift
//  EcommerceDemo
//
//  Created by Nitesh Meshram on 3/14/18.
//  Copyright © 2018 NItesh. All rights reserved.
//

import Foundation
import UIKit


class ProductCategoryViewController: ViewController {
 
    let CellIdentifier = "Cell"
    var categoryList: [ProductlCategory]?
    
    var productCategory: ProductlCategory?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryList = DataManager.sharedInstance.fetchAllCategories()
        
//        print("categoryList!.count ====>>\(categoryList!.count)")
        
//        DataManager.sharedInstance.fetchAllRainking()
        
    }
    
}


extension ProductCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (categoryList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath as IndexPath)
        
        let category = categoryList![indexPath.row] as ProductlCategory
        
        cell.textLabel?.text = category.catagoryName
        
        
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       print("didSelectRowAt")
        productCategory = categoryList![indexPath.row] as ProductlCategory
        performSegue(withIdentifier: "productSegue", sender: nil)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        let productViewController = segue.destination as? ProductViewController
        productViewController?.productCategory = productCategory

    }
}

