//
//  ProductList+CoreDataProperties.swift
//  EcommerceDemo
//
//  Created by V2Solutions on 18/03/18.
//  Copyright © 2018 NItesh. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductList> {
        return NSFetchRequest<ProductList>(entityName: "ProductList")
    }

    @NSManaged public var productAddedDate: String?
    @NSManaged public var productId: String?
    @NSManaged public var productName: String?
    @NSManaged public var tax: String?
    @NSManaged public var vat: String?
    @NSManaged public var categoryDetails: ProductlCategory?
    @NSManaged public var variantsDetails: NSSet?
    @NSManaged public var rankingDetails: Rankings?

}

// MARK: Generated accessors for variantsDetails
extension ProductList {

    @objc(addVariantsDetailsObject:)
    @NSManaged public func addToVariantsDetails(_ value: VariantsList)

    @objc(removeVariantsDetailsObject:)
    @NSManaged public func removeFromVariantsDetails(_ value: VariantsList)

    @objc(addVariantsDetails:)
    @NSManaged public func addToVariantsDetails(_ values: NSSet)

    @objc(removeVariantsDetails:)
    @NSManaged public func removeFromVariantsDetails(_ values: NSSet)

}
