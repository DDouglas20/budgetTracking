//
//  CurrentMonthData+CoreDataProperties.swift
//  
//
//  Created by DeQuan Douglas on 9/29/21.
//
//

import Foundation
import CoreData


extension CurrentMonthData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentMonthData> {
        return NSFetchRequest<CurrentMonthData>(entityName: "CurrentMonthData")
    }

    @NSManaged public var totalBudgetArray: NSObject?
    @NSManaged public var purchases: NSOrderedSet?

}

// MARK: Generated accessors for purchases
extension CurrentMonthData {

    @objc(insertObject:inPurchasesAtIndex:)
    @NSManaged public func insertIntoPurchases(_ value: PurchasesViewModel, at idx: Int)

    @objc(removeObjectFromPurchasesAtIndex:)
    @NSManaged public func removeFromPurchases(at idx: Int)

    @objc(insertPurchases:atIndexes:)
    @NSManaged public func insertIntoPurchases(_ values: [PurchasesViewModel], at indexes: NSIndexSet)

    @objc(removePurchasesAtIndexes:)
    @NSManaged public func removeFromPurchases(at indexes: NSIndexSet)

    @objc(replaceObjectInPurchasesAtIndex:withObject:)
    @NSManaged public func replacePurchases(at idx: Int, with value: PurchasesViewModel)

    @objc(replacePurchasesAtIndexes:withPurchases:)
    @NSManaged public func replacePurchases(at indexes: NSIndexSet, with values: [PurchasesViewModel])

    @objc(addPurchasesObject:)
    @NSManaged public func addToPurchases(_ value: PurchasesViewModel)

    @objc(removePurchasesObject:)
    @NSManaged public func removeFromPurchases(_ value: PurchasesViewModel)

    @objc(addPurchases:)
    @NSManaged public func addToPurchases(_ values: NSOrderedSet)

    @objc(removePurchases:)
    @NSManaged public func removeFromPurchases(_ values: NSOrderedSet)

}
