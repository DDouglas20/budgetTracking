//
//  PurchasesViewModel+CoreDataProperties.swift
//  
//
//  Created by DeQuan Douglas on 9/29/21.
//
//

import Foundation
import CoreData


extension PurchasesViewModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PurchasesViewModel> {
        return NSFetchRequest<PurchasesViewModel>(entityName: "PurchasesViewModel")
    }

    @NSManaged public var date: Date?
    @NSManaged public var category: String?
    @NSManaged public var userDescription: String?
    @NSManaged public var price: String?
    @NSManaged public var uniqueLabel: Int16

}
