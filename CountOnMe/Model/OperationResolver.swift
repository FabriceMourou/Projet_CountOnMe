import Foundation


class OperationResolver {
    
    // MARK: - INTERNAL
    
    // MARK: - Inits
    
    init(mathOperatorConverter: MathOperatorConverter = MathOperatorConverter()) {
        self.mathOperatorConverter = mathOperatorConverter
    }
    
    private let mathOperatorConverter: MathOperatorConverter
    
    func getResult(elements: [String]) throws -> String {
        
        var operationsToReduce = elements
        var operationUnitIndex = 0
        
        while operationsToReduce.count > 1 {
            
            guard
                let left = Double(operationsToReduce[operationUnitIndex]),
                let right = Double(operationsToReduce[operationUnitIndex + 2])
                else {
                    throw CalculatorError.cannotGetLeftAndRightNumberForOperationUnit
            }
            
            let mathOperatorSymbolString = operationsToReduce[operationUnitIndex + 1]
            
            guard let mathOperator = mathOperatorConverter.convertSymbolToMathOperator(symbol: mathOperatorSymbolString) else {
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
    
    // MARK: Methods - Private
    
    private func getIsPrioritiesRemaining(in operationsToReduce: [String]) -> Bool {
        
        return operationsToReduce.contains {
            guard let mathOperator = mathOperatorConverter.convertSymbolToMathOperator(symbol: $0) else {
                return false
            }
            
            return mathOperator.isPriorityOperator
        }
    }
}
