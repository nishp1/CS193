//
//  ViewController.swift
//  Calculator
//
//  Created by Nish Patel on 2/6/15.
//  Copyright (c) 2015 Nish Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var isUserInMiddleOfTypingNumber:Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if (isUserInMiddleOfTypingNumber) {
            label.text = label.text! + digit;
        }
        else {
            label.text = digit
            isUserInMiddleOfTypingNumber = true
        }
    }
}

