//
//  PreviousMonths+CoreDataProperties.swift
//  
//
//  Created by DeQuan Douglas on 9/29/21.
//
//

import Foundation
import CoreData


extension PreviousMonths {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PreviousMonths> {
        return NSFetchRequest<PreviousMonths>(entityName: "PreviousMonths")
    }

    @NSManaged public var month: Date?
    @NSManaged public var totalSpendingArray: NSObject?
    @NSManaged public var monthPurchases: NSOrderedSet?

}

// MARK: Generated accessors for monthPurchases
extension PreviousMonths {

    @objc(insertObject:inMonthPurchasesAtIndex:)
    @NSManaged public func insertIntoMonthPurchases(_ value: PurchasesViewModel, at idx: Int)

    @objc(removeObjectFromMonthPurchasesAtIndex:)
    @NSManaged public func removeFromMonthPurchases(at idx: Int)

    @objc(insertMonthPurchases:atIndexes:)
    @NSManaged public func insertIntoMonthPurchases(_ values: [PurchasesViewModel], at indexes: NSIndexSet)

    @objc(removeMonthPurchasesAtIndexes:)
    @NSManaged public func removeFromMonthPurchases(at indexes: NSIndexSet)

    @objc(replaceObjectInMonthPurchasesAtIndex:withObject:)
    @NSManaged public func replaceMonthPurchases(at idx: Int, with value: PurchasesViewModel)

    @objc(replaceMonthPurchasesAtIndexes:withMonthPurchases:)
    @NSManaged public func replaceMonthPurchases(at indexes: NSIndexSet, with values: [PurchasesViewModel])

    @objc(addMonthPurchasesObject:)
    @NSManaged public func addToMonthPurchases(_ value: PurchasesViewModel)

    @objc(removeMonthPurchasesObject:)
    @NSManaged public func removeFromMonthPurchases(_ value: PurchasesViewModel)

    @objc(addMonthPurchases:)
    @NSManaged public func addToMonthPurchases(_ values: NSOrderedSet)

    @objc(removeMonthPurchases:)
    @NSManaged public func removeFromMonthPurchases(_ values: NSOrderedSet)

}
