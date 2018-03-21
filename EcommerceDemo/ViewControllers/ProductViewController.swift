//
//  ProductViewController.swift
//  EcommerceDemo
//
//  Created by Nitesh Meshram on 3/14/18.
//  Copyright © 2018 NItesh. All rights reserved.
//

import Foundation
import UIKit

class ProductViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var expandedCellIdentifier = "ExpandableCell"
    
    
    
    var cellWidth:CGFloat{
        return collectionView.frame.size.width
    }
    var expandedHeight : CGFloat = 200
    var notExpandedHeight : CGFloat = 50
    
    var productDataSource: NSArray = []
    var isExpanded = [Bool]()
    


    var productCategory: ProductlCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ((productCategory?.productDetails?.count) != nil) {
            
            self.productDataSource = productCategory?.productDetails?.allObjects as! NSArray
            
        }
        
        self.title = productCategory?.catagoryName
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: expandedCellIdentifier)
        isExpanded = Array(repeating: false, count: productDataSource.count)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    

}


extension ProductViewController: UICollectionViewDataSource{
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

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isExpanded[indexPath.row] == true{
            return CGSize(width: cellWidth, height: expandedHeight)
        }else{
            return CGSize(width: cellWidth, height: notExpandedHeight)
        }
        
    }
    
}

extension ProductViewController: ProductTableViewCellDelegate {
    func topButtonTouched(indexPath: IndexPath) {
        isExpanded[indexPath.row] = !isExpanded[indexPath.row]
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.collectionView.reloadItems(at: [indexPath])
        }, completion: { success in
            print("success")
        })
    }
}

