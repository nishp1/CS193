//
//  ViewController.swift
//  Calculator
//
//  Created by Nish Patel on 2/6/15.
//  Copyright (c) 2015 Nish Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    var isUserInMiddleOfTypingNumber = false
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if (isUserInMiddleOfTypingNumber) {
            display.text = display.text! + digit;
        }
        else {
            display.text = digit
            isUserInMiddleOfTypingNumber = true
        }
    }
    
    @IBAction func onEnter() {
        isUserInMiddleOfTypingNumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        }
        else {
            displayValue = 0
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if isUserInMiddleOfTypingNumber {
            onEnter()
        }
        
        if let operation = sender.currentTitle {
            
            if let result = brain.performOperation(operation) {
                displayValue = result
            }
            else {
                displayValue = 0
            }
        }
        
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            isUserInMiddleOfTypingNumber = false
        }
    }
}

