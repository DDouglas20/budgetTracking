//
//  ViewController.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 8/28/21.
//

import UIKit
import Charts

class BudgetScreenViewController: UIViewController {
    //MARK: Properties
    let budget = 1000
    let spending: [Double] = [172, 50, 20, 30]
    let colors: [UIColor] = [.blue,.green,.purple,.red]
    let uiChartView: UIView = {
        let view = UIView()
        view.frame = view.bounds
        view.backgroundColor = .green
        return view
    }()

    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myVC = BudgetScreenViewController()
        let navVC = UINavigationController(rootViewController: myVC)
        myVC.title = "Welcome _"
        renderChart()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        uiChartView.frame = view.bounds
    }

    //MARK: Private
    private func renderChart() {
        view.addSubview(uiChartView)
        let test: UILabel = {
            let label = UILabel()
            label.text = "TEST"
            label.font = .systemFont(ofSize: 30)
            label.sizeToFit()
            return label
        }()
        
        let chartView = BudgetChartView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: view.height/3
            )
        )
        
        uiChartView.addSubview(test)
        
        chartView.configure(
            with: .init(
                data: spending,
                colors: colors
            )
        )
        uiChartView.addSubview(chartView)
        
    }
    private func getData() {
        
    }
    
    
    //MARK: Public

}

extension BudgetScreenViewController: ChartViewDelegate {
    
}

