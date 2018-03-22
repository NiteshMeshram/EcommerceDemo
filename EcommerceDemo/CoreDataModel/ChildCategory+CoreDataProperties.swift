//
//  ChildCategory+CoreDataProperties.swift
//  EcommerceDemo
//
//  Created by Nitesh Meshram on 3/22/18.
//  Copyright © 2018 NItesh. All rights reserved.
//
//

import Foundation
import CoreData


extension ChildCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChildCategory> {
        return NSFetchRequest<ChildCategory>(entityName: "ChildCategory")
    }

    @NSManaged public var subCategoryId: String?
    @NSManaged public var parentCategory: ProductlCategory?

}
