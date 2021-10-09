//
//  BudgetSummaryViewController.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 9/2/21.
//

import UIKit
import CoreData

class PreviousBudgetsViewController: UIViewController {
    
    // ****** Reformat CoreData so a date is passed instead of a month ******* //
    // ****** Date formatter will be used to pull the month and year   ******* //
    
    private let persistanceAccess = PersistenceManager.shared
    
    static let cellIdentifier = "PreviousBudgetsCell"
    
    private var dateStringArray = [String]()
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Previous Budgets"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        updateArrayDateString()
        tableView.delegate = self
        tableView.dataSource = self
        print(dateStringArray)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    //MARK: Functions
    private func updateArrayDateString() {
        let fetchRequest: NSFetchRequest<PreviousMonths> = PreviousMonths.fetchRequest()
        
        do {
            let previousMonthsArray = try PersistenceManager.context.fetch(fetchRequest)
            print(previousMonthsArray.count)
            for index in 0..<previousMonthsArray.count {
                dateStringArray.append(persistanceAccess.changeDateToStringReduced(date: previousMonthsArray[index].month!))
            }
        } catch { print("Could not fetch previousMonthsData") }
        
        self.tableView.reloadData()
    }


}





//MARK: Table View
extension PreviousBudgetsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateStringArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PreviousBudgetsViewController.cellIdentifier) else { fatalError() }
        cell.accessoryType = .detailDisclosureButton
        print("This should be label: \(dateStringArray[indexPath.row])")
        cell.textLabel?.text = dateStringArray[indexPath.row]
        return cell
    }
    
    
}
