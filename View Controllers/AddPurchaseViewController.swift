//
//  AddPurchaseViewController.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 9/1/21.
//

import UIKit

class AddPurchaseViewController: UIViewController {
    
    //MARK: Propeties
    //private var shouldAppendOnce = Bool()
    //private var shouldAppendTwice = Bool()
    private var date = String()
    private var userDescription = String()
    private var price = Double()
    private var category: String?
    private let categoryDefault = "Entertainment"
    private let persistanceAccess = PersistenceManager.shared
    private var updateIndex = 1
    private var shouldChangeColor = true
    private var categoryImage = UIImage()
    
    private let addPurchaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Purchase"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        
        return label
    }()
    
    private let addPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = .systemFont(ofSize: 20, weight: .black)
        
        return label
    }()
    
    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Price"
        textField.keyboardType = .decimalPad
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.black.cgColor
        textField.returnKeyType = .continue
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        
        
        return textField
    }()
    
    private let addDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = .systemFont(ofSize: 20, weight: .black)
        
        return label
    }()
    
    private let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Description of Purchase"
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 3
        textField.layer.borderColor = UIColor.black.cgColor
        textField.returnKeyType = .continue
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        
        return textField
    }()
    
    private let addDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = .systemFont(ofSize: 20, weight: .black)
        
        
        return label
    }()
    
    private let datePickerField: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = .autoupdatingCurrent
        
        return datePicker
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = .systemFont(ofSize: 20, weight: .black)
        
        return label
    }()
    
    private let categoryPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        
        return pickerView
    }()
    
    private let addPurchaseButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .systemBackground
        button.setTitle("Add Purchase", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        
        return button
    }()
    

    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTapGesture()
        view.backgroundColor = .systemBackground
        priceTextField.delegate = self
        descriptionTextField.delegate = self
        categoryPickerView.delegate = self
        navigationItem.title = "Add Purchase"
        addPurchaseButton.addTarget(self, action: #selector(addPurchase), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if traitCollection.userInterfaceStyle == .dark {
            addPurchaseButton.layer.borderColor = UIColor.white.cgColor
            descriptionTextField.layer.borderColor = UIColor.white.cgColor
            priceTextField.layer.borderColor = UIColor.white.cgColor
            shouldChangeColor = false
            print(shouldChangeColor)
        }
        else {
            addPurchaseButton.layer.borderColor = UIColor.black.cgColor
            descriptionTextField.layer.borderColor = UIColor.black.cgColor
            priceTextField.layer.borderColor = UIColor.black.cgColor
            shouldChangeColor = true
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
                if shouldChangeColor == true {
                    addPurchaseButton.layer.borderColor = UIColor.white.cgColor
                    descriptionTextField.layer.borderColor = UIColor.white.cgColor
                    priceTextField.layer.borderColor = UIColor.white.cgColor
                    shouldChangeColor = false
                }
                else {
                    addPurchaseButton.layer.borderColor = UIColor.black.cgColor
                    descriptionTextField.layer.borderColor = UIColor.black.cgColor
                    priceTextField.layer.borderColor = UIColor.black.cgColor
                    shouldChangeColor = true
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubviews(addPurchaseLabel, addPriceLabel, priceTextField, addDescriptionLabel, descriptionTextField, addDateLabel, datePickerField, categoryLabel, categoryPickerView, addPurchaseButton)
        
        addPurchaseLabel.sizeToFit()
        addPurchaseLabel.frame = CGRect(x: 0,
                                        y: 5,
                                        width: view.width,
                                        height: addPurchaseLabel.height)
        addPriceLabel.sizeToFit()
        addPriceLabel.frame = CGRect(x: 5,
                                     y: view.height * 0.12,
                                     width: view.width,
                                     height: addPriceLabel.height)
        priceTextField.sizeToFit()
        priceTextField.frame = CGRect(x: 5,
                                      y: addPriceLabel.bottom + 5,
                                      width: view.width - 10,
                                      height: 35)
        addDescriptionLabel.sizeToFit()
        addDescriptionLabel.frame = CGRect(x: 5,
                                           y: priceTextField.bottom + 15,
                                           width: view.width,
                                           height: addDescriptionLabel.height)
        descriptionTextField.sizeToFit()
        descriptionTextField.frame = CGRect(x: 5,
                                            y: addDescriptionLabel.bottom + 5,
                                            width: view.width - 10,
                                            height: 35)
        addDateLabel.sizeToFit()
        addDateLabel.frame = CGRect(x: 5,
                                    y: descriptionTextField.bottom + 15,
                                    width: view.width,
                                    height: addDateLabel.height)
        
        datePickerField.frame = CGRect(x: 5,
                                       y: addDateLabel.bottom + 5,
                                       width: view.width - 10,
                                       height: 35)
        categoryLabel.sizeToFit()
        categoryLabel.frame = CGRect(x: 5,
                                     y: datePickerField.bottom + 15,
                                     width: view.width - 10,
                                     height: categoryLabel.height)
        categoryPickerView.sizeToFit()
        categoryPickerView.frame = CGRect(x: 5,
                                          y: datePickerField.bottom,
                                          width: view.width - 10,
                                          height: categoryPickerView.height)
        addPurchaseButton.sizeToFit()
        addPurchaseButton.frame = CGRect(x: 5,
                                         y: categoryPickerView.bottom + 5,
                                         width: view.width - 10,
                                         height: 50)
    }
    
    //MARK: Private
    // NOTE FOR TOMORROW:
    //          -  APPEND THE DATA FROM THE FIELDS TO THE PURCHASES ARRAY
    //          - TOTAL DATA IS ACCOUNTED FOR
    //          - PURCHESES ARRAY HANDLES THE DATA FOR THE TABLE VIEW
    //          - ONCE APPENDED IT SHOULD APPEAR
    //          - DISMISS VIEW CONTROLLER AFTER
    @objc private func addPurchase() {
        // Unwrap the textFields
        guard let priceString = priceTextField.text,
        let descriptionString = descriptionTextField.text else {
            return
        }
        
        // Prepare the data for the table view & update uniquelabel
        changeDateToString()
        userDescription = descriptionString
        price = Double(priceString) ?? 0
        let uniqueLabel = persistanceAccess.uniqueLabelManager + 1
        persistanceAccess.uniqueLabelManager = uniqueLabel
        
        let finalPriceString = "$\(priceString)"
        
        // Update the budget left for the chart render
        persistanceAccess.totalBudgetArray[updateIndex] += price
        if persistanceAccess.totalBudgetArray[0] - price < 0 {
            persistanceAccess.totalBudgetArray[0] = 0
        }
        else {
            persistanceAccess.totalBudgetArray[0] -= price
        }
        
        // Troubleshoot the datepicker (maybe)
        print("This is date: \(datePickerField.date)")
        
        // Append the viewmodel in the viewmodel array for the table view
        persistanceAccess.purchasesArray.append(
            .init(
                date: date,
                image: categoryImage,
                description: userDescription,
                price: finalPriceString,
                uniqueLabel: uniqueLabel
            )
        )
        
        let purchasesViewModel = PurchasesViewModel(context: PersistenceManager.context)
        purchasesViewModel.date = datePickerField.date
        purchasesViewModel.category = category ?? categoryDefault
        purchasesViewModel.price = priceString
        purchasesViewModel.uniqueLabel = Int16(uniqueLabel)
        purchasesViewModel.userDescription = userDescription
        
        
        
        
        // Update persistence and saving coredata
        persistanceAccess.updatePurchasesArray() // This may be able to be deleted
        persistanceAccess.updateTotalSpendingArray() // This may be able to be deleted
        persistanceAccess.saveTotalBudgetData()
        UserDefaults.standard.setValue(true, forKey: "hasSavedPurchase")
        
        PersistenceManager.saveContext()
        
        NotificationCenter.default.post(name: .didAddPurchase, object: nil)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func changeDateToString() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        date = dateFormatter.string(from: datePickerField.date)
    }
    
    private func initializeTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: Public

}

//MARK: Extesnions
extension AddPurchaseViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == priceTextField {
            descriptionTextField.becomeFirstResponder()
        }
        
        if textField == descriptionTextField {
            descriptionTextField.resignFirstResponder()
        }
        
        if textField.returnKeyType == .done {
            resignFirstResponder()
        }
        return true
    }
    
}

extension AddPurchaseViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return persistanceAccess.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return persistanceAccess.categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        category = persistanceAccess.categories[row]
        guard let unwrappedImage = persistanceAccess.arrayImages[category ?? categoryDefault] as? UIImage else { return }
        categoryImage = unwrappedImage
        print(categoryImage)
        return updateIndex = row + 1
    }
    
}
