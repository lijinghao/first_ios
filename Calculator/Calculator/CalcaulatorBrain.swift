//
//  CalcaulatorBrain.swift
//  Calculator
//
//  Created by lijinghao on 15/10/13.
//  Copyright © 2015年 lijinghao. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op: CustomStringConvertible {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]() //等同于Array<Op>()
    private var knownOps = [String:Op]()
    
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("×", *))
        knownOps["÷"] =  Op.BinaryOperation("÷") { $1 / $0 }
        knownOps["+"] =  Op.BinaryOperation("+", +)
        knownOps["-"] =  Op.BinaryOperation("-") { $1 - $0 }
        knownOps["√"] =  Op.UnaryOperation("√", sqrt)
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {//返回了一个元祖
        
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                    
                }
                
            }
        }
        return (nil, ops);
    }
    
    func evaluate() -> Double? {//这里不直接返回Double而是Double？，例如当只有一个运算符时用户就要执行家法，那么就返回一个nil
        let (result, remainder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
        
    }
    
    func pushOperand(operand: Double) -> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double?{
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}