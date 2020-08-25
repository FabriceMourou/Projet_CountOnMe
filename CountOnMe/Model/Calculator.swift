//
//  Calculator.swift
//  CountOnMe
//
//  Created by Fabrice Mourou on 21/08/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol CalculatorDelegate: class {
    func didUpdateOperationString(textToCompute: String)
}


class Calculator {
    
    // MARK: - INTERNAL
    
    // MARK: Properties - Internal
    
    weak var delegate: CalculatorDelegate?
    
    
    // MARK: Methods - Internal
    
    func addDigit(_ digit: Int) {
        if expressionHaveResult {
            textToCompute.removeAll()
        }
        
        textToCompute.append(digit.description)
    }
    
    func addMathOperator(_ mathOperator: MathOperator) throws {
        guard canAddOperator else {
            throw CalculatorError.cannotAddOperatorAfterAnotherOperator
        }
        
        textToCompute.append(" \(mathOperator.symbol) ")
    }
    
    func resolveOperation() throws {
        guard expressionIsCorrect else {
            throw CalculatorError.expressionIsIncorrect
        }
        
        guard expressionHaveEnoughElement else {
            throw CalculatorError.expressionHasNotEnoughElement
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "×": result = left * right
            case "÷":
                guard right != 0 else {
                    throw CalculatorError.cannotDivideByZero
                }
                result = left / right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        textToCompute.append(" = \(operationsToReduce.first!)")
    }
    
    
    func resetOperation() {
        textToCompute.removeAll()
    }
    
    
    
    
    // MARK: - PRIVATE
    
    // MARK: Properties - Private
    
    private var textToCompute: String = "" {
        didSet {
            delegate?.didUpdateOperationString(textToCompute: textToCompute)
        }
    }
    
    private var elements: [String] {
        return textToCompute.split(separator: " ").map { "\($0)" }
    }
    
    private var expressionIsCorrect: Bool {
        return !isLastElementMathOperator
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return !isLastElementMathOperator
    }
    
    private var isLastElementMathOperator: Bool {
        MathOperator.allCases.contains {
            $0.symbol == elements.last
        }
    }
    
    private var expressionHaveResult: Bool {
        return textToCompute.firstIndex(of: "=") != nil
    }
}
