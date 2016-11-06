//
//  ViewController.swift
//  Calculatar
//
//  Created by 焦国辉 on 2016/11/6.
//  Copyright © 2016年 scau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var isMiddle = false
    private var brain = CalculatarBrain()
    @IBOutlet private weak var display: UILabel!
    
    
    private var displayValue: Double {
        get{
            
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    
    @IBAction private func digitTouch(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if isMiddle {
            let curDisplay = display.text!
            display.text = curDisplay + digit
        }else{
            display.text = digit
        }
        isMiddle = true
        
    }
    
    
    @IBAction private func operations(_ sender: UIButton) {
        if isMiddle {
            brain.set(operrand: displayValue)
            isMiddle = false
        }
        
        if let symbol = sender.currentTitle{
            brain.perform(symbol: symbol)

        }
        displayValue = brain.result
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

