//
//  PersistenceManager.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 8/28/21.
//
import UIKit
import Foundation
import CoreData


final class PersistenceManager {
    // *** Need to insert the purchase into this struct then create function to create view model *** //
    //MARK: Persistence Properties
    public struct PurchasesArrayStruct {
        let date: Date
        let category: String
        let description: String
        let price: String
        var uniqueLabel: Int
        
    }
    
    public var hasSavedPurchase = UserDefaults.standard.value(forKey: "hasSavedPurchase") ?? false
    
    public var previousMonthsArray: [PreviousMonths] = []
    
    public var purchasesViewModel: [PurchasesViewModel] = []
    
    public var purchasesStructArray: [PurchasesArrayStruct] = []
    
    public var newUser = UserDefaults.standard.value(forKey: "newUser") ?? true
    
    static let shared = PersistenceManager()
    
    public var budgetMonth = String()
    
    static var monthsBudget = Double()
    
    //MARK: Chart Properties
    // The first index is always the budget for both
    public let budgetColors: [UIColor] = [.systemGreen, .red, .systemBlue, .black, .systemPurple, .yellow]
    
    public var totalBudgetArray: [Double] = [0.00,0.00,0.00,0.00,0.00,0.00]
    
    //MARK: Other Properties
    public var uniqueLabelManager: Int = 0
    
    public var categories = ["Entertainment", "Expenses", "Groceries", "Emergency", "Other"]
    
    public let arrayImages =
        [
            "Entertainment": UIImage(systemName: "plus.app"),
            "Expenses": UIImage(systemName: "plus.circle"),
            "Groceries": UIImage(systemName: "plus.square"),
            "Emergency": UIImage(systemName: "plus.rectangle"),
            "Other": UIImage(systemName: "plus.diamond")
        ]
    
    //MARK: Table View Properties
    public var purchasesArray: [PurchasesTableViewCell.ViewModel] = []
    
    // We need to safe to userDefaults using categories instead of images
    // Then use the category to get the image
    
    
    //MARK: Functions
    public func removeFromPurchasesArray(viewModel: [PurchasesTableViewCell.ViewModel], uniqueLabel: Int) {
        var newPurchasesArray: [PurchasesTableViewCell.ViewModel] = []
        for model in viewModel {
            if model.uniqueLabel != uniqueLabel {
                newPurchasesArray.append(model)
            }
        }
        
        purchasesArray = newPurchasesArray
        
    }
    
    public func changeDateToString(date: Date) -> String {
        var dateString = String()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    public func changeDateToStringReduced(date: Date) -> String {
        var dateString = String()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-YYYY"
        dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    public func updatePurchasesArray() {
        
    }
    
    public func updateTotalSpendingArray() {
        
    }
    
    /// Converts the struct into the viewmodel by
    public func createViewModelFromStruct() {
        
    }
    
    
    //MARK: Core Data Related
    
    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "BudgetTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //MARK: Saving and Updating
    public func saveMonth() {
        // At the end of each month save the purchasesArray, totalPurchasesArray, and months
        let month = PreviousMonths(context: PersistenceManager.context)
        //month.month = budgetMonth
        month.totalSpendingArray = totalBudgetArray as NSObject
        PersistenceManager.saveContext()
    }
    
    
    //****** THIS NEEDS TO BE CREATED DURING THE WELCOME SCREEN. NOT IN ADD PURCHASES VC **********//
    
    /// If no entries were made create a core data object and then save it
    public func createCoreDataObject() {
        // Create the core data entry for processing
        let currentMonth = CurrentMonthData(context: PersistenceManager.context)
        currentMonth.totalBudgetArray = totalBudgetArray as NSObject
        
        PersistenceManager.saveContext()
    }
    
    /// Allows User to update their total budget
    public func updateTotalBudget() {
        
    }
    
    /// Saves the user input to coreData
    public func saveTotalBudgetData() {
        
        let fetchRequest: NSFetchRequest<CurrentMonthData> = CurrentMonthData.fetchRequest()
        print("We're entering here")
        do {
            let currentMonth = try PersistenceManager.context.fetch(fetchRequest)
            // Save the totalSpendingArray
            currentMonth[0].setValue(totalBudgetArray, forKey: "totalBudgetArray")
            
            
            
        } catch { print("Could not get data and save it") }
        
        return 
    }
    
    /// Updates persistence values to the coreData values since they are erased upon exit
    public func updatePersistingData() {
        
        let fetchRequest: NSFetchRequest<CurrentMonthData> = CurrentMonthData.fetchRequest()
        
        do {
            let currentMonth = try PersistenceManager.context.fetch(fetchRequest)
            
            if !currentMonth.isEmpty {
                totalBudgetArray = currentMonth[0].totalBudgetArray as! [Double]
                
            }
            
             
        } catch { print("Could not update persistence values") }
        
        if hasSavedPurchase as? Bool == true {
            let fetchRequest2: NSFetchRequest<PurchasesViewModel> = PurchasesViewModel.fetchRequest()
            
            do {
                let viewModel = try PersistenceManager.context.fetch(fetchRequest2)
                
                purchasesViewModel = viewModel
                
                for entity in purchasesViewModel {
                    purchasesArray.append(
                        .init(
                            date: changeDateToString(date: entity.date!),
                            image: arrayImages[entity.category!]!!,
                            description: entity.userDescription!,
                            price: entity.price!,
                            uniqueLabel: Int(entity.uniqueLabel))
                    )
                }
                
            } catch { print("This does not work") }
        }
        
        
        
        let fetchRequest3: NSFetchRequest<PreviousMonths> = PreviousMonths.fetchRequest()
        
        do {
            
            
        } catch { print("No previous months data yet") }
        
        
        return
    }
    
    // MARK: Deletion Requests
    
    /// Deletes the purchase and all data associated with it
    public func deletePurchase(row: Int) {
        let fetchRequest: NSFetchRequest<PurchasesViewModel> = PurchasesViewModel.fetchRequest()
        
        do {
            var viewModel = try PersistenceManager.context.fetch(fetchRequest)
            
            var index = 0
            let price = Double(viewModel[row].price!)
            let category = viewModel[row].category
            print("this is array count: \(purchasesArray.count)")
            for i in 0..<categories.count {
                print("This is i: \(i)")
                if categories[i] == category {
                    
                    print("category total before: \(totalBudgetArray[i+1])")
                    totalBudgetArray[i+1] -= price!
                    print("Category total after: \(totalBudgetArray[i+1])")
                    print("total budget leftoever before: \(totalBudgetArray[0])")
                    totalBudgetArray[0] += price!
                    print("total budget leftoever after: \(totalBudgetArray[0])")
                    purchasesArray.remove(at: row)
                }
            }
            
            PersistenceManager.context.delete(viewModel[row])
            
            PersistenceManager.saveContext()
            print("Successfully deleted")
            
        } catch { print("Cannot delete information") }
        
        let fetchRequest2: NSFetchRequest<CurrentMonthData> = CurrentMonthData.fetchRequest()
        
        do {
            var currentMonth = try PersistenceManager.context.fetch(fetchRequest2)
            currentMonth[0].setValue(totalBudgetArray, forKey: "totalBudgetArray")
            print("This is total budget array: \(totalBudgetArray)")
            print("This is the coredata budget array: \(currentMonth[0].totalBudgetArray)")
            
            PersistenceManager.saveContext()
        } catch { print("Could not override total budget array")}
        
    }

    // MARK: - Core Data Saving support

    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("SAVED")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

