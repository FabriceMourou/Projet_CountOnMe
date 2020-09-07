//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe


class CalculatorTestCases: XCTestCase {
    
    var calculator: Calculator!
    var calculatorDelegateMock: CalculatorDelegateMock!
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
        calculatorDelegateMock = CalculatorDelegateMock()
        calculator.delegate = calculatorDelegateMock
    }
    
    
    // MARK: - AddDigit
    
    
    func testAddDigit_WhenAddSingleDigit_ThenAppendDigit() {
        calculator.addDigit(3)
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "3")
    }
    
    
    func testAddDigit_WhenAddMultipleDigits_ThenAppendDigits() {
        calculator.addDigit(1)
        calculator.addDigit(3)
        calculator.addDigit(7)
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "137")
    }
    
    
    func testAddDigit_WhenAddZeroDigit_ThenAppendDigit() {
        calculator.addDigit(0)
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "0")
    }
    
    func testAddDigit_WhenAddMultipleZeroDigits_ThenOnlyOneZero() {
        calculator.addDigit(0)
        calculator.addDigit(0)
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "0")
    }
    
    
    
    func testAddDigit_WhenAddSinleZeroAfterDigit_ThenAppendDigits() {
        calculator.addDigit(1)
        calculator.addDigit(0)
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "10")
    }
    
    
    
    func testAddDigit_WhenAddMultipleZeroAfterDigit_ThenAppendDigits() {
        calculator.addDigit(1)
        calculator.addDigit(0)
        calculator.addDigit(0)
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "100")
    }
    
    
    func testAddDigit_WhenAddZeroBeforeDigit_ThenAppendDigitWithoutZero() {
        calculator.addDigit(0)
        calculator.addDigit(1)
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "1")
    }
    
    func testAddDigit_WhenAddDigitsAndMathOperator_ThenAppendOnlyLastDigit() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(2)
        try! calculator.resolveOperation()
        calculator.addDigit(1)
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "1")
    }
    
    
    // MARK: - addMathOperator
    
    func testAddMathOperator_WhenAddDigitAndPlusMathOperator_ThenAppendDigitAndMathOperator() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        
        
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "1 + ")
    }
    
    func testAddMathOperator_WhenAddDigitAndMinusMathOperator_ThenAppendDigitAndMathOperator() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.minus)
        
        
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "1 - ")
    }
    
    func testAddMathOperator_WhenAddDigitAndMultiplyMathOperator_ThenAppendDigitAndMathOperator() {
        calculator.addDigit(5)
        try! calculator.addMathOperator(.multiply)
        
        
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "5 × ")
    }
    
    func testAddMathOperator_WhenAddDigitAndDivideMathOperator_ThenAppendDigitAndMathOperator() {
        calculator.addDigit(5)
        try! calculator.addMathOperator(.divide)
        
        
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "5 ÷ ")
    }
    
    
    func testAddMathOperator_WhenAddDigitsAndMathOperators_ThenAppendDigitsAndMathOperators() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        

        XCTAssertEqual(calculatorDelegateMock.textToCompute, "1 + 1 + ")
    }
    
    
    
    func testAddMathOperator_WhenAddDigitsAndDifferentMathOperators_ThenAppendPriorityOperation() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(4)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "1 + 2 × 4 = 9")
    }
    
    
    func testAddMathOperator_WhenAddDigitsAndDifferentMathOperators_ThenAppendPriorityOperationASD() {
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
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "1 + 2 × 4 + 2 × 4 = 17")
    }
    
    func testAddMathOperator_WhenAddDigitsAndDifferentMathOperators_ThenAppendPriorityOperationASDasd() {
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
         XCTAssertEqual(calculatorDelegateMock.textToCompute, "1 + 2 × 4 + 2 × 4 + 2 = 19")
     }
    
    func testAddMathOperator_WhenAddDigitsAndDifferentMathOperators_ThenAppendPriorityOperationASDasdA(){
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(2)
        try! calculator.addMathOperator(.multiply)
        calculator.addDigit(2)
        try! calculator.addMathOperator(.divide)
        calculator.addDigit(3)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "2 × 2 × 2 ÷ 3 = 2.66666")
    }
    
    
    func testAddMathOperator_WhenAddMathOperatorFirst_ThenDisplayAnError() {
        XCTAssertThrowsError(try calculator.addMathOperator(.plus), "") { (error) in
            let error = error as! CalculatorError
            XCTAssertEqual(error, CalculatorError.cannotAddOperatorIfOperationEmpty)
        }
    }
    
    func testAddMathOperator_WhenAddMathOperatorAfterMathOperator_ThenDisplayAnError() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.multiply)
        XCTAssertThrowsError(try calculator.addMathOperator(.divide), "") { (error) in
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
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "1 + 2 = 3")
    }
    
    func testResolveOperation_WhenAddDigitsAndMathOperatorMinus_ThenAppendDigitsAndMathOperatorsAndResult() {
        calculator.addDigit(2)
        try! calculator.addMathOperator(.minus)
        calculator.addDigit(1)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "2 - 1 = 1")
    }
    
    func testResolveOperation_WhenAddDigitsAndMathOperatorMultiply_ThenAppendDigitsAndMathOperatorsAndResult() {
           calculator.addDigit(2)
           try! calculator.addMathOperator(.multiply)
           calculator.addDigit(2)
           try! calculator.resolveOperation()
           XCTAssertEqual(calculatorDelegateMock.textToCompute, "2 × 2 = 4")
       }
    
    func testResolveOperation_WhenAddDigitsAndMathOperatorDivide_ThenAppendDigitsAndMathOperatorsAndResult() {
           calculator.addDigit(4)
           try! calculator.addMathOperator(.divide)
           calculator.addDigit(2)
           try! calculator.resolveOperation()
           XCTAssertEqual(calculatorDelegateMock.textToCompute, "4 ÷ 2 = 2")
       }
    
    func testResolveOperation_WhenAddEqualOperatorAfterMathOperator_ThenDisplayAnError() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.multiply)
        XCTAssertThrowsError(try calculator.resolveOperation(), "") { (error) in
            let error = error as! CalculatorError
            XCTAssertEqual(error, CalculatorError.expressionIsIncorrect)
        }
        
    }

    
    func testResolveOperation_WhenAddOneDigitAndEqualOperatorAfter_ThenDisplayAnError() {
        calculator.addDigit(1)
        XCTAssertThrowsError(try calculator.resolveOperation(), "") { (error) in
            let error = error as! CalculatorError
            XCTAssertEqual(error, CalculatorError.expressionHasNotEnoughElement)
        }
        
    }
    
     func testResolveOperation_WhenDivideByZero_ThenDisplayAnError() {
         calculator.addDigit(4)
        try! calculator.addMathOperator(.divide)
        calculator.addDigit(0)
         XCTAssertThrowsError(try calculator.resolveOperation(), "") { (error) in
             let error = error as! CalculatorError
             XCTAssertEqual(error, CalculatorError.cannotDivideByZero)
         }
         
     }
    
    
    // MARK: - resetOperation
    
    func testResetOperation_WhenAddResetOperation_ThenRemoveAll() {
        calculator.resetOperation()
        XCTAssertTrue(true)
    }
    
    
}
