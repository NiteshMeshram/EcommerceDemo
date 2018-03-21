//
//  ProductCollectionViewCell.swift
//  EcommerceDemo
//
//  Created by Nitesh Meshram on 3/15/18.
//  Copyright © 2018 NItesh. All rights reserved.
//

import Foundation
import UIKit

protocol ProductTableViewCellDelegate:NSObjectProtocol{
    func topButtonTouched(indexPath:IndexPath)
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var colorSegment: UISegmentedControl!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var taxType: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var topButton: UIButton!
    weak var delegate:ProductTableViewCellDelegate?
    
    public var indexPath:IndexPath!
    

    
    
    var product: ProductList! {
        didSet {
            
            if let productName = product.productName {
               self.productNameLabel.text = productName
            }
            
            if let productAddedDate = product.productAddedDate {
                self.dateLabel.text = productAddedDate
            }
            
            if let varients = product.variantsDetails {
                if let allVarients = varients.allObjects as? [VariantsList] {
                    
                    colorSegment.replaceSegments(segments: allVarients)
                }
            }
            

        }
        
    }
    
    
    
    
    
    @IBAction func topButtonTouched(_ sender: UIButton) {
        if let delegate = self.delegate{
            delegate.topButtonTouched(indexPath: indexPath)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UILabel.appearance(whenContainedInInstancesOf: [UISegmentedControl.self]).numberOfLines = 0
        //custom logic goes here
    }
    
    
}

extension UISegmentedControl {
    func replaceSegments(segments: [VariantsList]) {
        self.removeAllSegments()
        
        segments.forEach { variant in
            let variantDetails = """
            \(variant.variantSize!)
            \(variant.variantColor!)
            ₹\(variant.variantPrice!)
            """

//            self.backgroundColor = self.colorTheme(colorName: variant.variantColor!)
            self.insertSegment(withTitle: variantDetails , at: self.numberOfSegments, animated: false)
            
        }
        

    }
    
    func colorTheme (colorName: String) -> UIColor {
        switch colorName {
        case "Red":
            return UIColor.red
        case "Yellow":
            return UIColor.yellow
        case "Blue":
            return UIColor.blue
        case "White":
            return UIColor.white
        case "Black":
            return UIColor.black
        case "Orange":
            return UIColor.orange
        case "Green":
            return UIColor.green
        default:
            return UIColor.white
        }
    }
}


