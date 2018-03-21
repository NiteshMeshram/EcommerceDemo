//
//  ViewController.swift
//  EcommerceDemo
//
//  Created by NItesh on 10/03/18.
//  Copyright © 2018 NItesh. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let service = APIService()
        
        service.getDataWith { (result) in
            switch result {
            case .Success(let data):

                DataManager.sharedInstance.saveInCoreDataWith(array: data)
                if let products: [ProductList] = DataManager.sharedInstance.fetchData(entityName: "ProductList") {
                    
                    /*
                    _ = products.map {
                        print( "\(String(describing:  $0.productName)), \(String(describing:  $0.categoryDetails?.catagoryName))")
                        
                    }
                    */

                }
            case .Error(let message):
                print(message)

            }
        }*/

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

