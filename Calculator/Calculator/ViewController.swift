//
//  ViewController.swift
//  Calculator
//
//  Created by lijinghao on 15/9/23.
//  Copyright (c) 2015年 lijinghao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsTheMiddleOfTypingANumber: Bool = false;
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!;
        if userIsTheMiddleOfTypingANumber {
            display.text = display.text! + digit;
        } else {
            display.text = digit;
            userIsTheMiddleOfTypingANumber = true;
        }
        
        
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!;
        if userIsTheMiddleOfTypingANumber {
            enter();
        }
        switch operation {
            case "×":   peformOperation { $0 * $1 }
            case "÷":   peformOperation { $1 / $0 }
            case "+":   peformOperation { $0 + $1 }
            case "-":   peformOperation { $1 - $0 }
            case "√":   peformSqrt { sqrt($0) }
            default:break;
        }
    }
    
    func peformOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            dispalyValue = operation(operandStack.removeLast(),operandStack.removeLast());
            enter();
        }
    }
    
    func peformSqrt(operation: Double -> Double){
        if operandStack.count >= 1 {
            dispalyValue = operation(operandStack.removeLast());
            enter();
        }
    }
    
    var  operandStack = Array<Double>();
    
    @IBAction func enter() {
        userIsTheMiddleOfTypingANumber = false;
        operandStack.append(dispalyValue);
        println("operandStack = \(operandStack)");//此句会调用get方法
        //dispalyValue = 1;//此句会调用set方法
        
    }
    
    var dispalyValue: Double {
        get {
            //println("heihei");
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue;
        }
        set {
            //println("haha");
            display.text = "\(newValue)";
            userIsTheMiddleOfTypingANumber = false;
        }
    }


}

