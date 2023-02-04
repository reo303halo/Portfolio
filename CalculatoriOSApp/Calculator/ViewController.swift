//
// ViewController.swift
//  Calculator
//
//  Created by Roy Espen Olsen on 27/03/2022.
//
//  Version 1.0 released for testing 04/04/2022 (On friends and family's devices)
//
//  Version 1.1 released for testing 08/04/2022 (On friends and family's devices)
//  Fixed greeting time, disabled rotation and highlight of pressed operand button.
//
//

import UIKit


class ViewController: UIViewController {
    
    var operand1: String = "0"
    
    var operand2: String = ""
    
    var calcOperator: Int = -1
    
    var result: String = ""
    
    
    @IBOutlet weak var calcDisplay: UILabel!
    
    
    @IBOutlet var calcButtons: [UIButton]!
    
    
    @IBOutlet weak var acButton: UIButton!
    
    
    @IBOutlet var opButtons: [UIButton]!
    
    
    @IBAction func allClear(_ sender: UIButton) {
        sender.setTitle("AC", for: [])
        
        operand1 = "0"
        
        operand2 = ""
        
        calcOperator = -1
        
        result = ""
        
        calcDisplay.text = "0"
        
        resetButtonColors()
    }
    
    
    @IBAction func toggleNegative(_ sender: UIButton) {
        if operand2 == "" {
            if operand1 != "0" {
                if let i = operand1.firstIndex(of: "-") {
                    operand1.remove(at: i)
                }
                else {
                    operand1 = "-" + operand1
                }
                calcDisplay.text = operand1
            }
        }
        
        else {
            if operand2 != "0" && operand2 != "" {
                if let i = operand2.firstIndex(of: "-") {
                    operand2.remove(at: i)
                }
                else {
                    operand2 = "-" + operand2
                }
                calcDisplay.text = operand2
            }
        }
    }
        
    
    @IBAction func nmPressed(_ sender: UIButton) {
        if calcOperator == -1 {
            if operand1 == result || operand1 == "0" {
                operand1 = ""
                operand1 += String(sender.tag)
                calcDisplay.text = operand1
            }
            else {
                operand1 += String(sender.tag)
                calcDisplay.text = operand1
            }
        }
        else if calcOperator != -1 {
            operand2 += String(sender.tag)
            calcDisplay.text = operand2
        }
    }
    
    
    @IBAction func addComma(_ sender: UIButton) {
        if operand2 == "" {
            if !operand1.contains(".") {
                operand1 += "."
                calcDisplay.text = operand1
            }
        }
        
        else {
            if !operand2.contains(".") {
                operand2 += "."
                calcDisplay.text = operand2
            }
        }
    }
    
    
    @IBAction func operatorButtons(_ sender: UIButton) {
        calcOperator = sender.tag
        acButton.setTitle("C", for: [])
        
        for buttons in opButtons {
            if buttons.tag == sender.tag {
                buttons.backgroundColor = .link
            }
            else {
                buttons.backgroundColor = .systemTeal
                if buttons.tag == 14 {
                    buttons.backgroundColor = .darkGray
                }
            }
        }
    }
    
    
    func resetButtonColors() {
        for buttons in opButtons {
            buttons.backgroundColor = .systemTeal
            if buttons.tag == 14 {
                buttons.backgroundColor = .darkGray
            }
        }
    }
    
    
    @IBAction func evaluate(_ sender: UIButton) {
        resetButtonColors()
        
        if operand1 != "" && operand2 != "" {
            
            
            if calcOperator == 10 {
                let tempResult = Double(operand1)! + Double(operand2)!
                
                result = String(tempResult)
            }
            
            else if calcOperator == 11 {
                let tempResult = Double(operand1)! - Double(operand2)!
                
                result = String(tempResult)
            }
            
            else if calcOperator == 12 {
                let tempResult = Double(operand1)! * Double(operand2)!
                
                result = String(tempResult)
            }
            
            else if calcOperator == 13 {
                let tempResult = Double(operand1)! / Double(operand2)!
                
                result = String(tempResult)
            }
            
            else if calcOperator == 14 {
                let tempResult = (Double(operand1)! / 100) * Double(operand2)!
                
                result = String(tempResult)
            }
            
            let finalResult = result.components(separatedBy: ".")
            if finalResult[1] == "0" {
                calcDisplay.text = finalResult[0]
                operand1 = finalResult[0]
            }
            else {
                calcDisplay.text = result
                operand1 = result
            }
            
            operand2 = ""
            calcOperator = -1
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in calcButtons {
            button.layer.cornerRadius = button.bounds.size.height / 2
        }
        
        
        let calendar = Calendar.current
        let date = Date()
        let hour = calendar.dateComponents([.hour], from: date)
        let now = hour.hour!
        
        
        var greeting = "Hello!"
        
        if 5 <= now && now <= 11 {
            greeting = "Good Morning!"
        }
        else if 12 <= now && now <= 16 {
            greeting = "Hello!"
        }
        else if 17 <= now && now <= 20 {
            greeting = "Good Evening!"
        }
        else if 21 <= now || now <= 4 {
            greeting = "Good Night!"
        }
        
        
        calcDisplay.text = greeting
        
    }
    
    
    override open var shouldAutorotate: Bool {
        return false
    }
}
