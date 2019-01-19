//
//  TipCalculatorViewController.swift
//  Tip Calculator
//
//  Created by Tammy Truong on 1/15/19.
//  Copyright © 2019 Tammy Truong. All rights reserved.
//

import UIKit

// Extension to hide the number keypad if there is an outside tap
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class TipCalculatorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var taxPercentTextField: UITextField!
    @IBOutlet weak var taxPercentLabel: UILabel!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var tipPercentSlider: UISlider!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var splitSlider: UISlider!
    
    @IBOutlet weak var totalSplitTaxLabel: UILabel!
    @IBOutlet weak var tipSplitLabel: UILabel!
    @IBOutlet weak var totalSplitTaxTipLabel: UILabel!
    @IBOutlet weak var totalBillTaxLabel: UILabel!
    @IBOutlet weak var totalBillTaxTipLabel: UILabel!
    
    // The tip calculator that does the actual calculation
    var tipCalculator = TipCalculator(bill: 0, taxPercent: 9.25, tipPercent: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        billTextField.delegate = self
        taxPercentTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: Target/Action
    // These functions calculate the bill according to any changes in the slider or inputs
    
    @IBAction func tipSliderValueChange(_ sender: Any) {
        tipPercentLabel.text = "Tip: \(Int(tipPercentSlider.value.rounded()))%"
        calculateBill()
    }
    
    @IBAction func splitSliderValueChange(_ sender: Any) {
        splitLabel.text = "Split: \(Int(splitSlider.value.rounded()))"
        calculateBill()
    }
    
    @IBAction func billValueChange(_ sender: Any) {
        calculateBill()
    }
    
    @IBAction func taxValueChange(_ sender: Any) {
        calculateBill()
    }
    
    // Helper methods
    
    // Takes the inputs from each text field and slider and calculates the costs
    func calculateBill() {
        tipCalculator.bill = (billTextField.text! as NSString).doubleValue
        tipCalculator.split = Double(splitSlider.value.rounded())
        tipCalculator.taxPercent = (taxPercentTextField.text! as NSString).doubleValue / 100
        tipCalculator.tipPercent = Double(tipPercentSlider.value.rounded()) / 100

        tipCalculator.calculateTotalTax()
        tipCalculator.calculateTotalTip()
        tipCalculator.calculateTipEach()
        
        updateUI()
    }
    
    // Updates the text labels according to the final calculations
    func updateUI() {
        totalBillTaxLabel.text = String(format: "$%0.2f", tipCalculator.totalTax)
        totalBillTaxTipLabel.text = String(format: "$%0.2f", tipCalculator.totalTaxTip)
        totalSplitTaxLabel.text = String(format: "$%0.2f", tipCalculator.totalTax / tipCalculator.split)
        totalSplitTaxTipLabel.text = String(format: "$%0.2f", tipCalculator.totalTaxTip / tipCalculator.split)
        tipSplitLabel.text = String(format: "$%0.2f", tipCalculator.tipEach)
    }

}
