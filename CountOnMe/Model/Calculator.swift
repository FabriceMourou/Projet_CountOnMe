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
    
    // MARK: - Inits
    
    init(
        operationResolver: OperationResolver = OperationResolver(),
        calculatorNumberFormatter: CalculatorNumberFormatter = CalculatorNumberFormatter()
    ) {
        self.operationResolver = operationResolver
        self.calculatorNumberFormatter = calculatorNumberFormatter
    }

    
    // MARK: Properties - Internal
    weak var delegate: CalculatorDelegate?
    // MARK: Methods - Internal
    
    func addDigit(_ digit: Int) {
        if expressionHaveResult {
            textToCompute.removeAll()
        }
        
        if elements.last == "0" {
            textToCompute.removeLast()
        }
        
        textToCompute.append(digit.description)
    }
    
    func addMathOperator(_ mathOperator: MathOperator) throws {
        try ensureCanAddOperator()
        
        textToCompute.append(" \(mathOperator.symbol) ")
    }
    
    func resolveOperation() throws {
        try ensureOperationIsCorrect()
        let result = try operationResolver.getResult(elements: elements)
        let formattedResult = try calculatorNumberFormatter.formatResult(result)
        addResultToOperationString(result: formattedResult)
    }
    
    func resetOperation() {
        textToCompute.removeAll()
    }
    
    // MARK: - PRIVATE
    
    // MARK: Properties - Private
    
    private let operationResolver: OperationResolver
    private let calculatorNumberFormatter: CalculatorNumberFormatter
    

    
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
    
    private var isLastElementMathOperator: Bool {
        MathOperator.allCases.contains {
            $0.symbol == elements.last
        }
    }
    
    private var expressionHaveResult: Bool {
        return textToCompute.firstIndex(of: "=") != nil
    }
    

    // MARK: Methods - Private
    
    private func ensureCanAddOperator() throws {
        guard !isLastElementMathOperator else {
            throw CalculatorError.cannotAddOperatorAfterAnotherOperator
        }
        
        guard !textToCompute.isEmpty else {
            throw CalculatorError.cannotAddOperatorIfOperationEmpty
        }
    }
    
    private func ensureOperationIsCorrect() throws {
        guard expressionIsCorrect else {
            throw CalculatorError.expressionIsIncorrect
        }
        
        guard expressionHaveEnoughElement else {
            throw CalculatorError.expressionHasNotEnoughElement
        }
    
    }
    
    private func addResultToOperationString(result: String) {
         textToCompute.append(" = \(result)")
    }
    
    
    
    
    
}


class CalculatorNumberFormatter {
    func formatResult(_ result: String) throws -> String {
        guard let resultAsDouble = Double(result) else {
            throw CalculatorError.cannotFormatInvalidStringNumber
        }
        
        let finalResult = resultAsDouble as NSNumber
        
        let numberFormatter = NumberFormatter()
        
        if resultAsDouble > 100000 {
            numberFormatter.numberStyle = .scientific
            numberFormatter.positiveFormat = "0.###E+0"
            numberFormatter.exponentSymbol = "e"
        } else {
            numberFormatter.numberStyle = .decimal
        }
        
        numberFormatter.maximumFractionDigits = 5
        numberFormatter.roundingMode = .up
        
        guard let formattedResult = numberFormatter.string(from: finalResult) else {
            throw CalculatorError.failedToFormatFinalResult
        }
        
        return formattedResult
    }
}
