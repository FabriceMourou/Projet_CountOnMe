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
        guard expressionIsCorrect else {
            throw CalculatorError.expressionIsIncorrect
        }

        guard expressionHaveEnoughElement else {
            throw CalculatorError.expressionHasNotEnoughElement
        }

        // Create local copy of operations
        var operationsToReduce = elements
        var operationUnitIndex = 0

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            print("Operation to reduce \(operationsToReduce)")

            print("Operation Unit index \(operationUnitIndex)")

            let left = Double(operationsToReduce[operationUnitIndex])!
            let operand = operationsToReduce[operationUnitIndex + 1]
            let right = Double(operationsToReduce[operationUnitIndex + 2])!

            let isPriorityOperatorRemaining = getIsPrioritiesRemaining(in: operationsToReduce)
            print("isPriorityOperatorRemaining \(isPriorityOperatorRemaining)")

            let isCurrentOperatorPriority = getIsPriorityOperator(mathOperator: operand)
            print("isCurrentOperatorPriority \(isCurrentOperatorPriority)")

            if isPriorityOperatorRemaining && !isCurrentOperatorPriority {
                operationUnitIndex += 2
                print("Il reste des opérateur prioritaires ET l'opérateur actuel n'est PAS prioritaire")
                print("On Incrémente l'operation unit index et va au prochain tour de boucle 😀")
                continue
            }

            let result: Double

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

            print("Operation unit index \(operationUnitIndex)")
            print("Operation à reduire AVANt de retirer \(operationsToReduce)")
            operationsToReduce.removeSubrange(operationUnitIndex...operationUnitIndex + 2)
            print("Operation à reduire APRES avoir retiré \(operationsToReduce)")

            operationsToReduce.insert("\(result)", at: operationUnitIndex)

            operationUnitIndex = 0
        }

        let finalResult = Double(operationsToReduce.first!)! as NSNumber

        print("Not converted REeuslt => \(finalResult)")

        let numberFormatter = NumberFormatter()

        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 5
        numberFormatter.roundingMode = .floor

        let formattedResult = numberFormatter.string(from: finalResult)!

        textToCompute.append(" = \(formattedResult)")
    }

    func getIsPrioritiesRemaining(in operationsToReduce: [String]) -> Bool {
        return operationsToReduce.contains("×") || operationsToReduce.contains("÷")
    }

    func getIsPriorityOperator(mathOperator: String) -> Bool {
        return mathOperator == "×" || mathOperator == "÷"
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

    private func ensureCanAddOperator() throws {
        guard !isLastElementMathOperator else {
            throw CalculatorError.cannotAddOperatorAfterAnotherOperator
        }

        guard !textToCompute.isEmpty else {
            throw CalculatorError.cannotAddOperatorIfOperationEmpty
        }
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
