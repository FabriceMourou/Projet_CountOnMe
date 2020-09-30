import Foundation

protocol OperationMakerDelegate: class {
    func didUpdateOperationString(textToCompute: String)
}

class OperationMaker {
    
    // MARK: - INTERNAL

    // MARK: Properties - Internal
    
    
    weak var delegate: OperationMakerDelegate?
    
    var elements: [String] {
        return operation.split(separator: " ").map { "\($0)" }
    }
   
    // MARK: Methods - Internal
    
    
    func addDigit(_ digit: Int) {
        if expressionHaveResult {
            operation.removeAll()
        }
        
        if elements.last == "0" {
            operation.removeLast()
        }
        
        operation.append(digit.description)
    }
    
    func addMathOperator(_ mathOperator: MathOperator) throws {
        try ensureCanAddOperator()
        
        operation.append(" \(mathOperator.symbol) ")
    }
    
    func resetOperation() {
        operation.removeAll()
    }
    
    
    func addResultToOperationString(result: String) {
         operation.append(" = \(result)")
    }
    
    // MARK: - PRIVATE
    
    // MARK: Properties - Private
    
    
    private var operation: String = "" {
        didSet {
            delegate?.didUpdateOperationString(textToCompute: operation)
        }
    }
    
    
    private var expressionHaveResult: Bool {
        return operation.firstIndex(of: "=") != nil
    }
    
    
    private var isLastElementMathOperator: Bool {
        MathOperator.allCases.contains {
            $0.symbol == elements.last
        }
    }
    
    // MARK: Methods - Private
    
    private func ensureCanAddOperator() throws {
        guard !isLastElementMathOperator else {
            throw CalculatorError.cannotAddOperatorAfterAnotherOperator
        }
        
        guard !operation.isEmpty else {
            throw CalculatorError.cannotAddOperatorIfOperationEmpty
        }
    }
    
   
}