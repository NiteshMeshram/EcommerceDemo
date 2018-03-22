//
//  Rankings+CoreDataProperties.swift
//  EcommerceDemo
//
//  Created by Nitesh Meshram on 3/22/18.
//  Copyright © 2018 NItesh. All rights reserved.
//
//

import Foundation
import CoreData


extension Rankings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rankings> {
        return NSFetchRequest<Rankings>(entityName: "Rankings")
    }

    @NSManaged public var rankingName: String?
    @NSManaged public var rankingTypeCount: String?
    @NSManaged public var productRanking: ProductList?

}
