//
//  ProductlCategory+CoreDataProperties.swift
//  EcommerceDemo
//
//  Created by Nitesh Meshram on 3/22/18.
//  Copyright © 2018 NItesh. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductlCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductlCategory> {
        return NSFetchRequest<ProductlCategory>(entityName: "ProductlCategory")
    }

    @NSManaged public var catagoryName: String?
    @NSManaged public var categoryId: String?
    @NSManaged public var childCategoryDetails: NSSet?
    @NSManaged public var productDetails: NSSet?

}

// MARK: Generated accessors for childCategoryDetails
extension ProductlCategory {

    @objc(addChildCategoryDetailsObject:)
    @NSManaged public func addToChildCategoryDetails(_ value: ChildCategory)

    @objc(removeChildCategoryDetailsObject:)
    @NSManaged public func removeFromChildCategoryDetails(_ value: ChildCategory)

    @objc(addChildCategoryDetails:)
    @NSManaged public func addToChildCategoryDetails(_ values: NSSet)

    @objc(removeChildCategoryDetails:)
    @NSManaged public func removeFromChildCategoryDetails(_ values: NSSet)

}

// MARK: Generated accessors for productDetails
extension ProductlCategory {

    @objc(addProductDetailsObject:)
    @NSManaged public func addToProductDetails(_ value: ProductList)

    @objc(removeProductDetailsObject:)
    @NSManaged public func removeFromProductDetails(_ value: ProductList)

    @objc(addProductDetails:)
    @NSManaged public func addToProductDetails(_ values: NSSet)

    @objc(removeProductDetails:)
    @NSManaged public func removeFromProductDetails(_ values: NSSet)

}
