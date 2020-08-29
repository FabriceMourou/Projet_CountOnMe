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
    
    
    
    func testAddDigit_WhenAddMultipleZeroDigits_ThenOnlyOneZeroAbd() {
        calculator.addDigit(1)
        calculator.addDigit(0)
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "10")
    }
    
    
    
    func testAddDigit_WhenAddMultipleZeroDigits_ThenOnlyOneZeroAbdasd() {
        calculator.addDigit(1)
        calculator.addDigit(0)
        calculator.addDigit(0)
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "100")
    }
    
    
    func testAddDigit_WhenAddMultipleZeroDigits_ThenOnlyOneZeroAbdasdasd() {
        calculator.addDigit(0)
        calculator.addDigit(1)
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "1")
    }
    
    func testAddDigit_WhenAddMultipleZeroDigits_ThenOnlyOneZeroAbdasdasdasd() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(2)
        try! calculator.resolveOperation()
        calculator.addDigit(1)
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "1")
    }

    
    
    // MARK: - resolveOperation
    
    func testAddDigit_WhenAddMultipleZeroDigits_ThenOnlyOneZeroAbdasdasdasdasd() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(2)
        try! calculator.resolveOperation()
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "1 + 2 = 3")
    }
    
    
    // MARK: - addMathOperator
    
    func testAddDigit_WhenAddMultipleZeroDigits_ThenOnlyOneZeroAbdasdasdasdasdasd() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        
    
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "1 + ")
    }
    
    
    func testAddDigit_WhenAddMultipleZeroDigits_ThenOnlyOneZeroAbdasdasasddasdasdasd() {
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        calculator.addDigit(1)
        try! calculator.addMathOperator(.plus)
        
        
        XCTAssertEqual(calculatorDelegateMock.textToCompute, "1 + 1 + ")
    }
    
    func testAddDigit_WhenAddMultipleZeroDigits_ThenOnlyOneZeroAbdasdasdaasdsdasdasd() {
        XCTAssertThrowsError(try calculator.addMathOperator(.plus), "") { (error) in
            let error = error as! CalculatorError
            XCTAssertEqual(error, CalculatorError.cannotAddOperatorIfOperationEmpty)
        }

    }

}
