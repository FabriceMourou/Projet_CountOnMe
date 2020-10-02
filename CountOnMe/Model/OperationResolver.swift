import Foundation


class OperationResolver {
    
    
    // MARK: - INTERNAL
    
    // MARK: - Inits
    
    init(mathOperatorConverter: MathOperatorConverter = MathOperatorConverter()) {
        self.mathOperatorConverter = mathOperatorConverter
    }
    
    
    // MARK: Methods - Internal
    
    func resolveOperation(elements: [String]) throws -> String {
        try ensureOperationIsCorrect(elements: elements)
        let result = try getResult(elements: elements)
        let formattedResult = try calculatorNumberFormatter.formatResult(result)
        return formattedResult
    }
    
    
    // MARK: - PRIVATE
    
    // MARK: Properties - Private
    
    private let calculatorNumberFormatter: CalculatorNumberFormatter = CalculatorNumberFormatter()
    
    private let mathOperatorConverter: MathOperatorConverter
    
    
    // MARK: Methods - Private
    
    private func getResult(elements: [String]) throws -> String {
        
        var operationsToReduce = elements
        var operationUnitIndex = 0
        
        while operationsToReduce.count > 1 {
            
            guard
                let left = Double(operationsToReduce[operationUnitIndex]),
                let right = Double(operationsToReduce[operationUnitIndex + 2]) else {
                    throw CalculatorError.cannotGetLeftAndRightNumberForOperationUnit
            }
            
            let mathOperatorSymbolString = operationsToReduce[operationUnitIndex + 1]
            
            guard let mathOperator = mathOperatorConverter.convertSymbolToMathOperator(symbol: mathOperatorSymbolString)
            else {
                throw CalculatorError.cannotConvertSymbolIntoMathOperator
            }
            
            let isPriorityOperatorRemaining = getIsPrioritiesRemaining(in: operationsToReduce)
            
            if isPriorityOperatorRemaining && !mathOperator.isPriorityOperator {
                operationUnitIndex += 2
                continue
            }
            
            let isDividingByZero = mathOperator == .divide && right == 0
            
            guard !isDividingByZero else {
                throw CalculatorError.cannotDivideByZero
            }
            
            let result = mathOperator.associatedOperation(left, right)
            
            operationsToReduce.removeSubrange(operationUnitIndex...operationUnitIndex + 2)
            
            operationsToReduce.insert("\(result)", at: operationUnitIndex)
            
            operationUnitIndex = 0
        }
        
        guard let finalResult = operationsToReduce.first else {
            throw CalculatorError.cannotGetFinalResult
        }
        
        return finalResult
    }
    

    
    private func getIsPrioritiesRemaining(in operationsToReduce: [String]) -> Bool {
        
        return operationsToReduce.contains {
            guard let mathOperator = mathOperatorConverter.convertSymbolToMathOperator(symbol: $0) else {
                return false
            }
            
            return mathOperator.isPriorityOperator
        }
    }
    
    private func getIsLastElementMathOperator(elements: [String]) -> Bool {
        MathOperator.allCases.contains {
            $0.symbol == elements.last
        }
    }
    
    private func getExpressionIsCorrect(elements: [String]) -> Bool {
        return !getIsLastElementMathOperator(elements: elements)
    }
    
    private func getExpressionHaveEnoughElement(elements: [String]) -> Bool {
        return elements.count >= 3
    }
    
    
    private func ensureOperationIsCorrect(elements: [String]) throws {
        guard getExpressionIsCorrect(elements: elements) else {
            throw CalculatorError.expressionIsIncorrect
        }
        
        guard getExpressionHaveEnoughElement(elements: elements) else {
            throw CalculatorError.expressionHasNotEnoughElement
        }
    
    }
    
   
    
}
