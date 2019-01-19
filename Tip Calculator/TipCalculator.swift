//
//  TipCalculator.swift
//  Tip Calculator
//
//  Created by Tammy Truong on 1/15/19.
//  Copyright © 2019 Tammy Truong. All rights reserved.
//

import Foundation

class TipCalculator {
    
    // MARK: Properties
    
    var bill: Double = 0
    var split: Double = 1
    var taxPercent: Double = 9.25
    var tip: Double = 0
    var tipEach: Double = 0
    var tipPercent: Double = 0
    var totalTax: Double = 0
    var totalTaxTip: Double = 0
    
    // Initialize the cost of the bill, tax percentage, and tip percentage
    init(bill: Double, taxPercent: Double, tipPercent: Double) {
        self.bill = bill
        self.taxPercent = taxPercent
        self.tipPercent = tipPercent
    }
    
    // Calculate the cost of the entire bill with  tax
    func calculateTotalTax() {
        let taxPercentage = taxPercent + 1
        totalTax = bill * taxPercentage
    }
    
    // Calculate the cost of tip and the cost of the bill with tax and tip
    func calculateTotalTip() {
        let tipPercentage = tipPercent
        tip = bill * tipPercentage
        totalTaxTip = totalTax + tip
    }
    
    // Calculate the split of the tip
    func calculateTipEach() {
        tipEach = tip / split
    }
    
}
