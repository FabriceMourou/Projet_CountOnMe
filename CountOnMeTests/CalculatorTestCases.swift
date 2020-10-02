import XCTest
@testable import CountOnMe

//swiftlint:disable line_length

class CalculatorTestCases: XCTestCase {
    
    var calculator: Calculator!
    var calculatorDelegateMock: CalculatorDelegateMock!
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
        calculator.setup()
        calculatorDelegateMock = CalculatorDelegateMock()
        calculator.delegate = calculatorDelegateMock
    }
    
    
    
    // MARK: - AddDigit
    
    
    func testAddDigit_WhenAddSingleDigit_ThenAppendDigit() {
        calculator.addDigit(3)
        XCTAssertEqual(calculatorDelegateMock.operation, "3")
    }
    
    
    func testAddDigit_WhenAddMultipleDigits_ThenAppendDigits() {
        calculator.addDigit(1)
        calculator.addDigit(3)
        calculator.addDigit(7)
        XCTAssertEqual(calculatorDelegateMock.operation, "137")
    }
    
    
    func testAddDigit_WhenAddZeroDigit_ThenAppendDigit() {
        calculator.addDigit(0)
        XCTAssertEqual(calculatorDelegateMock.operation, "0")
    }
    
    
    func testAddDigit_WhenAddMultipleZeroDigits_ThenOnlyOneZero() {
        calculator.addDigit(0)
        calculator.addDigit(0)
        XCTAssertEqual(calculatorDelegateMock.operation, "0")
    }
    
    
    func testAddDigit_WhenAddSinleZeroAfterDigit_ThenAppendDigits() {
        calculator.addDigit(1)
        calculator.addDigit(0)
        XCTAssertEqual(calculatorDelegateMock.operation, "10")
    }
    
    
    func testAddDigit_WhenAddMultipleZeroAfterDigit_ThenAppendDigits() {
        calculator.addDigit(1)
        calculator.addDigit(0)
        calculator.addDigit(0)
        XCTAssertEqual(calculatorDelegateMock.operation, "100")
    }
    
    
    func testAddDigit_WhenAddZeroBeforeDigit_ThenAppendDigitWithoutZero() {
        calculator.addDigit(0)
        calculator.addDigit(1)
        XCTAssertEqual(calculatorDelegateMock.operation, "1")
    }
    
    
    func testAddDigit_WhenAddDigitsAndMathOperator_ThenAppendOnlyLastDigit() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(2)
        try! calculator.resolveOperation()
        calculator.addDigit(1)
        XCTAssertEqual(calculatorDelegateMock.operation, "1")
    }
    
    
    
    // MARK: - addMathOperator
    
    
    func testAddMathOperator_WhenAddDigitAndPlusMathOperator_ThenAppendDigitAndMathOperator() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        
        XCTAssertEqual(calculatorDelegateMock.operation, "1 + ")
    }
    
    
    func testAddMathOperator_WhenAddDigitAndMinusMathOperator_ThenAppendDigitAndMathOperator() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.minus)
        
        XCTAssertEqual(calculatorDelegateMock.operation, "1 - ")
    }
    
    
    func testAddMathOperator_WhenAddDigitAndMultiplyMathOperator_ThenAppendDigitAndMathOperator() {
        calculator.addDigit(5)
        try! calculator.addMathOperator(.multiply)
        
        XCTAssertEqual(calculatorDelegateMock.operation, "5 × ")
    }
    
    
    func testAddMathOperator_WhenAddDigitAndDivideMathOperator_ThenAppendDigitAndMathOperator() {
        calculator.addDigit(5)
        try! calculator.addMathOperator(.divide)
        
        XCTAssertEqual(calculatorDelegateMock.operation, "5 ÷ ")
    }
    
    
    func testAddMathOperator_WhenAddDigitsAndMathOperators_ThenAppendDigitsAndMathOperators() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        
        XCTAssertEqual(calculatorDelegateMock.operation, "1 + 1 + ")
    }
    
    
    func testAddMathOperator_WhenAddMathOperatorFirst_ThenDisplayAnError() {
        XCTAssertThrowsError(try calculator.addMathOperator(.plus)) { (error) in
            let error = error as! CalculatorError
            XCTAssertEqual(error, CalculatorError.cannotAddOperatorIfOperationEmpty)
        }
    }
    
    
    func testAddMathOperator_WhenAddMathOperatorAfterMathOperator_ThenDisplayAnError() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.multiply)
        XCTAssertThrowsError(try calculator.addMathOperator(.divide)) { (error) in
            let error = error as! CalculatorError
            XCTAssertEqual(error, CalculatorError.cannotAddOperatorAfterAnotherOperator)
        }
    }
    
    
    
    // MARK: - resolveOperation
    
    
    func testResolveOperation_WhenAddDigitsAndMathOperatorPlus_ThenAppendDigitsAndMathOperatorsAndResult() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(2)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.operation, "1 + 2 = 3")
    }
    
    
    func testResolveOperation_WhenAddDigitsAndMathOperatorMinus_ThenAppendDigitsAndMathOperatorsAndResult() {
        calculator.addDigit(2)
        try! calculator.addMathOperator(.minus)
        calculator.addDigit(1)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.operation, "2 - 1 = 1")
    }
    
    
    func testResolveOperation_WhenAddDigitsAndMathOperatorMultiply_ThenAppendDigitsAndMathOperatorsAndResult() {
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(2)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.operation, "2 × 2 = 4")
    }
    
    
    func testResolveOperation_WhenAddDigitsAndMathOperatorDivide_ThenAppendDigitsAndMathOperatorsAndResult() {
        calculator.addDigit(4)
        try! calculator.addMathOperator(.divide)
        calculator.addDigit(2)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.operation, "4 ÷ 2 = 2")
    }
    
    
    func testResolveOperation_WhenAddDigitsAndDifferentMathOperators_ThenAppendPriorityOperation() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(4)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.operation, "1 + 2 × 4 = 9")
    }
    
    
    func testResolveOpreration_WhenAddDigitsAndSameMathOperators_ThenAppendResult() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(4)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.operation, "1 × 2 × 4 = 8")
    }
    
    
    func testResolveOpreration_WhenAddDigitsAndThreeSameMathOperators_ThenAppendResult() {
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(4)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(16)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.operation, "2 × 2 × 4 × 16 = 256")
    }
    
    
    func testResolveOpreration_WhenAddDigitsAndThreeMathOperators_ThenAppendResult() {
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(4)
        try! calculator.addMathOperator(.divide)
        calculator.addDigit(16)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.operation, "2 × 2 × 4 ÷ 16 = 1")
    }
    
    
    func testResolveOpreration_WhenAddDigitsAndDifferentMathOperators_ThenAppendTwoPrioritiesOperation() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(4)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(4)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.operation, "1 + 2 × 4 + 2 × 4 = 17")
    }
    
    
    func testResolveOpreration_WhenAddDigitsAndDifferentMathOperators_ThenAppendTwoPrioritiesOperationAndEndWithANonPriorityOperation() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(4)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(4)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(2)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.operation, "1 + 2 × 4 + 2 × 4 + 2 = 19")
    }
    
    
    func testResolveOpreration_WhenAddDigitsAndDifferentMathOperators_ThenAppendDecimalOperation() {
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(2)
        try! calculator.addMathOperator(.divide)
        calculator.addDigit(3)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.operation, "2 × 2 × 2 ÷ 3 = 2.66667")
    }
    
    
    func testResolveOpreration_WhenAddDigitZero_ThenDisplayAnError() {
        calculator.addDigit(2)
        try! calculator.addMathOperator(.divide)
        calculator.addDigit(0)
        
        XCTAssertThrowsError(try calculator.resolveOperation(), "") { (error) in
            XCTAssertEqual(error as! CalculatorError, CalculatorError.cannotDivideByZero)
        }
    }
    
    
    func testResolveOpreration_WhenAddDigitsAndFalseMathOperator_ThenDisplayAnError() {
        let operationResolver = OperationResolver()
        
        XCTAssertThrowsError(try operationResolver.resolveOperation(elements: ["3", "a", "5"]), "") { (error) in
            XCTAssertEqual(error as! CalculatorError, CalculatorError.cannotConvertSymbolIntoMathOperator)
        }
    }
    
    
    func testResolveOpreration_WhenAddFalseDigitAndMathOperator_ThenDisplayAnError() {
        let operationResolver = OperationResolver()
        
        XCTAssertThrowsError(try operationResolver.resolveOperation(elements: ["a", "+", "5"]), "") { (error) in
            XCTAssertEqual(error as! CalculatorError, CalculatorError.cannotGetLeftAndRightNumberForOperationUnit)
        }
    }
    
    
    func testResolveOpreration_WhenFormatResultIsInvalid_ThenDisplayAnError() {
        let calculatorNumberFormatter = CalculatorNumberFormatter()
        
        XCTAssertThrowsError(try calculatorNumberFormatter.formatResult("a"), "") { (error) in
            XCTAssertEqual(error as! CalculatorError, CalculatorError.cannotFormatInvalidStringNumber)
        }
    }
    
    
    func testResolveOperation_WhenAddEqualOperatorAfterMathOperator_ThenDisplayAnError() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.multiply)
        
        XCTAssertThrowsError(try calculator.resolveOperation()) { (error) in
            let error = error as! CalculatorError
            XCTAssertEqual(error, CalculatorError.expressionIsIncorrect)
        }
    }
    
    
    func testResolveOperation_WhenAddOneDigitAndEqualOperatorAfter_ThenDisplayAnError() {
        calculator.addDigit(1)
        
        XCTAssertThrowsError(try calculator.resolveOperation()) { (error) in
            let error = error as! CalculatorError
            XCTAssertEqual(error, CalculatorError.expressionHasNotEnoughElement)
        }
    }
    
    
    func testResolveOperation_WhenAddMultipleDigitsAndMathOperatorMultiply_ThenAppendMultipleDigitsAndMathOperatorsAndExponentResult() {
        calculator.addDigit(100000000)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(100000000)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.operation, "100000000 × 100000000 = 1e+16")
    }
    
    
    
    // MARK: - resetOperation
    
    func testResetOperation_WhenAddResetOperation_ThenRemoveAll() {
        calculator.resetOperation()
        XCTAssertTrue(true)
    }
    
}
