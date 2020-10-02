import Foundation

protocol CalculatorDelegate: class {
    func didUpdateOperationString(operation: String)
}



class Calculator {
    
    // MARK: - INTERNAL

    // MARK: Properties - Internal
    weak var delegate: CalculatorDelegate?
    
    
    // MARK: Methods - Internal
    
    func setup() {
        operationMaker.delegate = self
    }
    
    func addDigit(_ digit: Int) {
        operationMaker.addDigit(digit)
    }
    
    func addMathOperator(_ mathOperator: MathOperator) throws {
        try operationMaker.addMathOperator(mathOperator)
    }
    
    func resetOperation() {
        operationMaker.resetOperation()
    }
   
    
    func resolveOperation() throws {
        let operationResult = try operationResolver.resolveOperation(elements: operationMaker.elements)
        operationMaker.addResultToOperationString(result: operationResult)
    }

    
    
    // MARK: - PRIVATE
    
    // MARK: Properties - Private
    
    private let operationMaker = OperationMaker()
    private let operationResolver = OperationResolver()
}


extension Calculator: OperationMakerDelegate {
    func didUpdateOperationString(textToCompute: String) {
        delegate?.didUpdateOperationString(operation: textToCompute)
    }
}
