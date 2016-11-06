//
//  CalculatarBrain.swift
//  Calculatar
//
//  Created by 焦国辉 on 2016/11/6.
//  Copyright © 2016年 scau. All rights reserved.
//

import Foundation



class CalculatarBrain {
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private struct BinaryInfo {
        var binaryFunc:(Double,Double) -> Double
        var firstOperand :Double
        
    }


    
    private var pending:BinaryInfo?
    private var accumlator = 0.0
    private var operations: Dictionary<String, Operation> =
    [
        "π" : Operation.constant(M_PI),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "sin": Operation.unaryOperation(sin),
        "tan": Operation.unaryOperation(tan),
        "±": Operation.unaryOperation({ -$0 }),
        "+" : Operation.binaryOperation(+),
        "-" : Operation.binaryOperation(-),
        "×" : Operation.binaryOperation(*),
        "÷" : Operation.binaryOperation(/),
        "=" : Operation.equals
    ]
    var result: Double {
        get{
            return accumlator
        }
    }
    
    private func executeBinaryOpreation() {
        if pending != nil{
            accumlator = pending!.binaryFunc(pending!.firstOperand, accumlator)
            pending = nil
        }
    }
    func set(operrand: Double)  {
        accumlator = operrand
    }
    
    func perform(symbol: String)  {
        
        if let operation = operations[symbol]{
            switch operation {
            case .constant(let value):
                accumlator = value
            case .unaryOperation(let function):
                accumlator = function(accumlator)
            case .binaryOperation(let function):
                executeBinaryOpreation()
                pending = BinaryInfo(binaryFunc: function, firstOperand: accumlator)
            case .equals:
                executeBinaryOpreation()
                
            
            }
        }
    }
    
}
