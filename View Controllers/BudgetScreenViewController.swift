//
//  ViewController.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 8/28/21.
//

import UIKit
import Charts
import CoreData

class BudgetScreenViewController: UIViewController {
    //MARK: Properties
    var spending = PersistenceManager.shared.totalBudgetArray
    let colors = PersistenceManager.shared.budgetColors
    
    private var observer: NSObjectProtocol?
    
    private var deleteRow: Int?
    
    private var didDeleteObserver: NSObjectProtocol?
    
    private var persistenceAccess = PersistenceManager.shared
    
    private var monthPurchases = [PurchasesTableViewCell.ViewModel]()
    
    private var uniqueLabelNumber = PersistenceManager.shared.uniqueLabelManager
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let noPurchasesLabel: UILabel = {
        let label = UILabel()
        label.text = "No Purchases Made This Month"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PurchasesTableViewCell.self, forCellReuseIdentifier: PurchasesTableViewCell.identifier)
        return tableView
    }()

    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        if persistenceAccess.newUser as? Bool == false {
            persistenceAccess.updatePersistingData()
        }
        updateMonthPurchases()
        renderChart()
        createTitleView()
        setUpTableView()
        createObserver()
        createDidDeleteObserver()
        setBudget()
        checkNewUser()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addPurchase)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "text.justify"),
            style: .plain,
            target: self,
            action: #selector(viewPastBudgets)
        )
        
        let previousMonthSave = PreviousMonths(context: PersistenceManager.context)
        previousMonthSave.month = Date()
        let orderedSet = NSOrderedSet(array: persistenceAccess.purchasesViewModel)
        previousMonthSave.monthPurchases = orderedSet
        previousMonthSave.totalSpendingArray = persistenceAccess.totalBudgetArray as NSObject
        PersistenceManager.saveContext()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //view.addSubview(addButton)
        addButton.sizeToFit()
        addButton.frame = CGRect(x: view.width / 1.2,
                                 y: view.height * 0.065,
                                 width: view.width * 0.09,
                                 height: view.width * 0.09)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if monthPurchases.count != 0 {
            tableView.isHidden = false
            noPurchasesLabel.isHidden = true
        }
        else {
            tableView.isHidden = true
            noPurchasesLabel.isHidden = false
            noPurchasesLabel.frame = CGRect(x: 0,
                                            y: view.height/2,
                                            width: view.width,
                                            height: view.height/2)
        }
        updateView()
    }
    

    //MARK: Private
    private func createObserver() {
        observer = NotificationCenter.default.addObserver(
            forName: .didAddPurchase,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                self?.monthPurchases = PersistenceManager.shared.purchasesArray
                self?.updateView()
                
            }
        )
    }
    
    private func createDidDeleteObserver() {
        didDeleteObserver = NotificationCenter.default.addObserver(
            forName: .didDeletePurchase,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                //self?.tableView.deleteRows(at: [IndexPath(row: self!.deleteRow!, section: 0)], with: .automatic)
                self?.updateMonthPurchases()
                self?.tableView.reloadData()
            }
        )
    }
    
    private func updateMonthPurchases() {
        monthPurchases = persistenceAccess.purchasesArray
    }
    
    private func updateView() {
        //renderChart()
        /*let arr = [UIColor.red, UIColor.green, UIColor.blue, UIColor.black]
        var i = 0
        for view in view.subviews {
            print(view.backgroundColor)
            view.backgroundColor = arr[i]
            i += 1
        }*/
        DispatchQueue.main.async {
            self.updateChartData()
            self.tableView.reloadData()
        }
        
    }
    
    private func updateChartData() {
        let chart = view.subviews[0] as? BudgetChartView
        spending = persistenceAccess.totalBudgetArray
        chart?.configure(
            with:
                .init(
                    data: spending,
                    colors: colors
                )
        )
    }
    
    private func createTitleView() {
        let titleView = UIView(frame: CGRect(x: 0,
                                             y: view.height / 4 - 125,
                                             width: view.width,
                                             height: view.height * 0.1))
        titleView.backgroundColor = .yellow
        let label = UILabel(frame: CGRect(x: view.width*0.02, y: view.height*0.02, width: titleView.width - 20, height: titleView.height))
        label.text = getMonth()
        label.textColor = .blue
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .medium)
        titleView.addSubview(label)
        //navigationItem.titleView = titleView
        view.addSubview(titleView)
        print("\(titleView.width) + This")
    }
    
    private func setUpTableView() {
        /*monthPurchases.append(.init(date: "May 2019", image: UIImage(systemName: "plus")!, description: "Test", price: "2.75", uniqueLabel: 0))*/
        view.addSubview(noPurchasesLabel)
        if monthPurchases.count == 0 {
            tableView.isHidden = true
            noPurchasesLabel.frame = CGRect(x: 0,
                                            y: view.height/1.9,
                                            width: view.width,
                                            height: view.height/3)
        }
        else {
            tableView.isHidden = false
        }
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .red
        tableView.clipsToBounds = true
        tableView.frame = CGRect(x: 0,
                                 y: view.height/1.9,
                                 width: view.width,
                                 height: view.height/2.2)
    }
    
    private func renderChart() {
        
        let boundsChartView = UIView(
            frame:
                CGRect(
                    x: 0,
                    y: view.height/4 - (navigationController?.navigationBar.height ?? 100) ,
                    width: view.width,
                    height: view.height/3
                )
        )
        boundsChartView.backgroundColor = .systemOrange
        
        let chartView = BudgetChartView(
            frame:
                CGRect(
                    x: 0,
                    y: view.height/4 - (navigationController?.navigationBar.height ?? 100) ,
                    width: view.width,
                    height: view.height/3.2
                )
        )
        
        /*let chartView = BudgetChartView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: view.height/3
            )
        )*/
        
        spending = persistenceAccess.totalBudgetArray
        
        chartView.backgroundColor = .systemOrange
        
        chartView.configure(
            with: .init(
                data: spending,
                colors: colors
            )
        )
        view.addSubview(chartView)
        /*boundsChartView.addSubview(chartView)
        view.addSubview(boundsChartView)*/
    }
    private func getData() {
        
    }
    
    private func setBudget() {
        PersistenceManager.monthsBudget = persistenceAccess.totalBudgetArray[0]
    }
    
    private func updateUniqueLabel() -> Int {
        let tempNum = uniqueLabelNumber
        self.uniqueLabelNumber += 1
        PersistenceManager.shared.uniqueLabelManager = self.uniqueLabelNumber
        return tempNum
    }
    
    private func getMonth() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let month = dateFormatter.string(from: date)
        persistenceAccess.budgetMonth = month
        return month
    }
    
    @objc private func addPurchase() {
        let vc = AddPurchaseViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func viewPastBudgets() {
        let vc = PreviousBudgetsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func checkNewUser() {
        guard let newUserBool = persistenceAccess.newUser as? Bool else { return }
        if newUserBool == true {
            let vc = WelcomeScreenViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    //MARK: Public

}

//MARK: Table View

extension BudgetScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PurchasesTableViewCell.identifier,
                for: indexPath
        ) as? PurchasesTableViewCell else { fatalError() }
        cell.accessoryType = .disclosureIndicator
        cell.configure(with: monthPurchases[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthPurchases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PurchasesTableViewCell.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            /*//Update persistence
            PersistenceManager.shared.removeFromPurchasesArray(viewModel: monthPurchases,
                                                               uniqueLabel: monthPurchases[indexPath.row].uniqueLabel)
            */
            
            //Update monthsPurchases & persistence
            monthPurchases.remove(at: indexPath.row)
            PersistenceManager.shared.purchasesArray = monthPurchases
            
            // Update table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.deleteRow = indexPath.row
        let date = persistenceAccess.purchasesArray[indexPath.row].date
        let price = persistenceAccess.purchasesArray[indexPath.row].price
        let descriptionText = persistenceAccess.purchasesArray[indexPath.row].description
        let vc = BreakdownViewController(date: date,
                                         price: price,
                                         descriptionText: descriptionText,
                                         row: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
}

//MARK: Extensions

extension BudgetScreenViewController: ChartViewDelegate {
    
}



