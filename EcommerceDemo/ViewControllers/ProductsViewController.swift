//
//  ProductsViewController.swift
//  EcommerceDemo
//
//  Created by Nitesh Meshram on 3/16/18.
//  Copyright © 2018 NItesh. All rights reserved.
//

import Foundation
import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var expandedCellIdentifier = "ExpandableCell"
    
    
    
    var cellWidth:CGFloat{
        return collectionView.frame.size.width
    }
    var expandedHeight : CGFloat = 200
    var notExpandedHeight : CGFloat = 50
    
    var productDataSource: NSArray = []
    var isExpanded = [Bool]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ((DataManager.sharedInstance.fetchAllProducts().count) != nil) {

            self.productDataSource = DataManager.sharedInstance.fetchAllProducts() as NSArray

        }
        
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: expandedCellIdentifier)
        isExpanded = Array(repeating: false, count: productDataSource.count)
    }
}


extension ProductsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: expandedCellIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        cell.product = productDataSource[indexPath.row] as! ProductList
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
        
    }
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isExpanded[indexPath.row] == true{
            return CGSize(width: cellWidth, height: expandedHeight)
        }else{
            return CGSize(width: cellWidth, height: notExpandedHeight)
        }
        
    }
    
}

extension ProductsViewController: ProductTableViewCellDelegate {
    func topButtonTouched(indexPath: IndexPath) {
        isExpanded[indexPath.row] = !isExpanded[indexPath.row]
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.collectionView.reloadItems(at: [indexPath])
        }, completion: { success in
            print("success")
        })
    }
}
