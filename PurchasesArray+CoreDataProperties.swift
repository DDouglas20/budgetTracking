//
//  PurchasesArray+CoreDataProperties.swift
//  
//
//  Created by DeQuan Douglas on 9/17/21.
//
//

import Foundation
import CoreData


extension PurchasesArray {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PurchasesArray> {
        return NSFetchRequest<PurchasesArray>(entityName: "PurchasesArray")
    }

    @NSManaged public var date: String?
    @NSManaged public var category: String?
    @NSManaged public var price: String?
    @NSManaged public var userDescription: String?
    @NSManaged public var uniqueLabel: Int32

}
