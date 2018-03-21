//
//  EcommerceTabbarController.swift
//  EcommerceDemo
//
//  Created by Nitesh Meshram on 3/14/18.
//  Copyright © 2018 NItesh. All rights reserved.
//

import Foundation
import UIKit

class EcommerceTabbarController: UITabBarController, UITabBarControllerDelegate {
 
    func requestApiForData () {
        
        let service = APIService()
        
        service.getDataWith { (result) in
            switch result {
            case .Success(let data):
                print(data)
                
//                DataManager.sharedInstance.saveCategoryInCoreDataWith(array: data["categories"] as! [[String : AnyObject]])
                
                
//                DataManager.sharedInstance.saveRankingInCoreDataWith(array: data["rankings"] as! [[String : AnyObject]])
                
                
                DataManager.sharedInstance.saveCategoryInCoreDataWith(array: data["categories"] as! [[String : AnyObject]], completion: { (success) in
                    if success {
                        DataManager.sharedInstance.saveRankingInCoreDataWith(array: data["rankings"] as! [[String : AnyObject]])
                    }
                    else {
                        
                        print("false")
                    }
                    
                })
                
                /*
                 
                 
                 
                 method(arg: true, completion: { (success) -> Void in
                 print("Second line of code executed")
                 if success { // this will be equal to whatever value is set in this method call
                 print("true")
                 } else {
                 print("false")
                 }
                 })
                 
                 */
                
            case .Error(let message):
                print(message)
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestApiForData()
        
        
    }
}
