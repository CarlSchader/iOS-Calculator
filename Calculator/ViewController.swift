//
//  ViewController.swift
//  Calculator
//
//  Created by Carl Schader on 3/25/18.
//  Copyright © 2018 CarlSchaderLearning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel?
    @IBOutlet weak var decimalPoint: UIButton?
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var timesButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    
    var storedOperatorValue: Double = 0
    var storedValue: String?
    var justTappedEquals: Bool = false
    
    var operatorSelected: Bool
    {
        get
        {
            if(plusButton.isSelected || minusButton.isSelected || timesButton.isSelected || divideButton.isSelected)
            {
                return true
            }
            else
            {
                return false
            }
        }
        set
        {
            if(newValue == false)
            {
                plusButton.isSelected = false
                minusButton.isSelected = false
                timesButton.isSelected = false
                divideButton.isSelected = false
                display!.text! = "0"
                storedOperatorValue = 0
                hasDecimalPoint = false
            }
        }
    }
    
    var displayValue: Double    // Computed Property
    {
        get
        {
            return Double(display!.text!)!
        }
        set
        {
            display!.text! = String(newValue)
        }
    }
    
    var hasDecimalPoint: Bool
    {
        get
        {
            if(display!.text!.contains("."))
            {
                return true
            }
            else
            {
                return false
            }
        }
        set
        {
            if(display!.text!.contains("."))
            {
                decimalPoint!.isSelected = true
            }
            else
            {
                decimalPoint!.isSelected = false
            }
        }
    }
    
    @IBAction func tapDigit(_ sender: UIButton)
    {
        if(justTappedEquals)
        {
            if(sender.currentTitle! == ".")
            {
                justTappedEquals = false
                display!.text! = "0."
                decimalPoint!.isSelected = true
                return
            }
            else
            {
                justTappedEquals = false
                display!.text! = sender.currentTitle!
                decimalPoint!.isSelected = false
                return
            }
        }
        if(display!.text! == "0")
        {
            if(sender.currentTitle! == ".")
            {
                display!.text! = "0."
                hasDecimalPoint = true
            }
            else
            {
                display!.text = sender.currentTitle!
            }
        }
        else if(hasDecimalPoint && sender.currentTitle! == ".")
        {
            // Do nothing
        }
        else
        {
            display!.text = display!.text! + sender.currentTitle!
            if(sender.currentTitle! == ".")
            {
                hasDecimalPoint = true
            }
        }
    }
    
    @IBAction func clear(_ sender: UIButton)
    {
        if(operatorSelected && display!.text! != "0")
        {
            display!.text! = "0"
            hasDecimalPoint = false
        }
        else if(operatorSelected && display!.text! == "0")
        {
            operatorSelected = false
            hasDecimalPoint = false
        }
        else
        {
            display!.text! = "0"
            hasDecimalPoint = false
        }
    }
    
    @IBAction func signChange(_ sender: UIButton)
    {
        var localInt: Int
        if(displayValue != 0)
        {
            if(displayValue.truncatingRemainder(dividingBy: 1) == 0 && !display!.text!.contains("-"))
            {
                display!.text! = "-" + display!.text!
            }
            else if(displayValue.truncatingRemainder(dividingBy: 1) == 0 && display!.text!.contains("-"))
            {
                localInt = Int(displayValue * (-1))
                display!.text! = String(localInt)
            }
            else
            {
                displayValue = displayValue * (-1)
            }
        }
    }
    
    @IBAction func operation(_ sender: UIButton)
    {
        var localDouble: Double
        var localString: String
        if(storedOperatorValue.truncatingRemainder(dividingBy: 1) == 0)
        {
            localString = String(Int(storedOperatorValue))
        }
        else
        {
            localString = String(storedOperatorValue)
        }
        
        if(!operatorSelected)
        {
            storedOperatorValue = displayValue
            display!.text! = "0"
            hasDecimalPoint = false
            switch sender.currentTitle!
            {
            case "+":
                plusButton.isSelected = !plusButton.isSelected
            case "-":
                minusButton.isSelected = !plusButton.isSelected
            case "x":
                timesButton.isSelected = !plusButton.isSelected
            case "÷":
                divideButton.isSelected = !plusButton.isSelected
            default:
                operatorSelected = false
            }
        }
        else if(sender.currentTitle == "+" && plusButton.isSelected)
        {
            operatorSelected = false
            display!.text! = localString
        }
        else if(sender.currentTitle == "-" && minusButton.isSelected)
        {
            operatorSelected = false
            display!.text! = localString
        }
        else if(sender.currentTitle == "x" && timesButton.isSelected)
        {
            operatorSelected = false
            display!.text! = localString
        }
        else if(sender.currentTitle == "÷" && divideButton.isSelected)
        {
            operatorSelected = false
            display!.text! = localString
        }
        else if(operatorSelected)
        {
            localDouble = storedOperatorValue
            switch sender.currentTitle!
            {
            case "+":
                operatorSelected = false
                display!.text! = "0"
                plusButton.isSelected = !plusButton.isSelected
                storedOperatorValue = localDouble
            case "-":
                operatorSelected = false
                display!.text! = "0"
                minusButton.isSelected = !plusButton.isSelected
                storedOperatorValue = localDouble
            case "x":
                operatorSelected = false
                display!.text! = "0"
                timesButton.isSelected = !plusButton.isSelected
                storedOperatorValue = localDouble
            case "÷":
                operatorSelected = false
                display!.text! = "0"
                divideButton.isSelected = !plusButton.isSelected
                storedOperatorValue = localDouble
            default:
                operatorSelected = false
            }
            operatorSelected = true
        }
    }
    
    @IBAction func equalsButtonTap(_ sender: UIButton)
    {
        var localDouble: Double = storedOperatorValue
        var localInt: Int
        storedOperatorValue = 0
        justTappedEquals = true
        
        if(operatorSelected)
        {
            if(plusButton.isSelected)
            {
                if(Double(localDouble + displayValue).truncatingRemainder(dividingBy: 1) == 0)
                {
                    localInt = Int(localDouble + displayValue)
                    operatorSelected = false
                    display!.text! = String(localInt)
                }
                else
                {
                    localDouble = localDouble + displayValue
                    operatorSelected = false
                    displayValue = localDouble
                    hasDecimalPoint = true
                }
            }
            else if(minusButton.isSelected)
            {
                if(Double(localDouble - displayValue).truncatingRemainder(dividingBy: 1) == 0)
                {
                    localInt = Int(localDouble - displayValue)
                    operatorSelected = false
                    display!.text! = String(localInt)
                }
                else
                {
                    localDouble = localDouble - displayValue
                    operatorSelected = false
                    displayValue = localDouble
                    hasDecimalPoint = true
                }
            }
            else if(timesButton.isSelected)
            {
                if(Double(localDouble * displayValue).truncatingRemainder(dividingBy: 1) == 0)
                {
                    localInt = Int(localDouble * displayValue)
                    operatorSelected = false
                    display!.text! = String(localInt)
                }
                else
                {
                    localDouble = localDouble * displayValue
                    operatorSelected = false
                    displayValue = localDouble
                    hasDecimalPoint = true
                }
            }
            else if(divideButton.isSelected)
            {
                if(Double(localDouble / displayValue).truncatingRemainder(dividingBy: 1) == 0)
                {
                    localInt = Int(localDouble / displayValue)
                    operatorSelected = false
                    display!.text! = String(localInt)
                }
                else
                {
                    localDouble = localDouble / displayValue
                    operatorSelected = false
                    displayValue = localDouble
                    hasDecimalPoint = true
                }
            }
            if(hasDecimalPoint)
            {
                hasDecimalPoint = true
            }
        }
        else if(!operatorSelected && displayValue == 0)
        {
            decimalPoint!.isSelected = false
            display!.text! = "0"
        }
        if(display!.text! == "0")
        {
            justTappedEquals = false
        }
    }
    
    @IBAction func storeTap(_ sender: UIButton)
    {
        if(!sender.isSelected)
        {
            sender.isSelected = true
            sender.setTitle("Load", for: UIControlState.normal)
            storedValue = display!.text!
            display!.text! = "0"
            hasDecimalPoint = false
        }
        else
        {
            sender.isSelected = false
            sender.setTitle("Store", for: UIControlState.normal)
            if(Double(storedValue!)!.truncatingRemainder(dividingBy: 1) == 0)
            {
                decimalPoint!.isSelected = false
            }
            else
            {
                decimalPoint!.isSelected = true
            }
            display!.text! = storedValue!
        }
    }
    
    
    
}







