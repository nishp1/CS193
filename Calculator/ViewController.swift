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
    var operandStack = Array<Double>()
    
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
        println(display.text!)
        operandStack.append(displayValue)
        println(operandStack)
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if isUserInMiddleOfTypingNumber {
            onEnter()
        }
        
        switch (operation) {
        case "×": performOperation{ $0 * $1 }
        case "÷": performOperation{ $1 / $0 }
        case "+": performOperation{ $0 + $1 }
        case "-": performOperation{ $1 - $0 }
        case "√": performOperation { sqrt($0) }
        default: break
        }
    }
    
    func performOperation (operation: (Double, Double) -> Double) {
        if (operandStack.count >= 2) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            onEnter()
        }
    }
    
    func performOperation (operation: Double -> Double) {
        if (operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast())
            onEnter()
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

