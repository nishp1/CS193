//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Nish Patel on 2/7/15.
//  Copyright (c) 2015 Nish Patel. All rights reserved.
//

import Foundation


class CalculatorBrain {

    private enum Op: Printable {
        case Operand(Double)
        case UniaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)

        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UniaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }

    private var opStack = [Op]()
    private var knownOps = [String: Op]()

    init () {
        func learnOp (op: Op) {
            knownOps[op.description] = op;
        }
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷") { $1 / $0 })
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("-", -))
        learnOp(Op.UniaryOperation("√", sqrt))
    }

    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }

    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }

    private func evaluate (ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        var remainingOps = ops;

        if (!remainingOps.isEmpty) {
            let op = remainingOps.removeLast()

            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)

            case .UniaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), remainingOps)
                }

            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)

                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }

                }
            default:
                return (nil, remainingOps)
            }
        }

        return (nil, remainingOps)
    }

    func evaluate () -> Double? {
        let (result, remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
}
